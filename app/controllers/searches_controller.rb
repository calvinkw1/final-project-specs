class SearchesController < ApplicationController
  # before_action :confirm_logged_in
  # before_action :prevent_login_signup, only: [:signup, :login]
  require 'json'

  def index
   @user = User.all
   binding.pry
    # Flightsearch_worker.perform_in(1.minutes, 2)
    # UserMailer.admin_email.deliver_now
    UserMailer.nightly_update.deliver_now
    # UserMailer.nightly_update.deliver_now
    # remove all of the above, only for testing
  end

  def new
    reqBody = params[:qpxData]
    flightRequest = Typhoeus::Request.new(
      "https://www.googleapis.com/qpxExpress/v1/trips/search?key=AIzaSyDE6F79FbnrSc9hZlurECTyBJoEyHCj-Nc",
      method: :post,
      headers: {'Content-Type'=> "application/json; charset=utf-8"},
      body: reqBody,
    )
    flightRequest.run
    @results = JSON.parse(flightRequest.response.body)
    respond_to do |format|
      format.html
      format.json { render json: {
        :results => @results
        }
      }
    end
  end

  def alertSearch
    # sidekiq will trigger the job which goes to the controller > method
    # need code to run the api call via typhoeus
    # return results into iVar
    # iterate thru iVar to check if price matches saved budget
    # if match, then fire off email to user
    reqBody = params[:qpxData] # pass in the stringified json obj here from the alerts table
    budget = 870.00
    flightRequest = Typhoeus::Request.new(
      "https://www.googleapis.com/qpxExpress/v1/trips/search?key=AIzaSyDE6F79FbnrSc9hZlurECTyBJoEyHCj-Nc",
      method: :post,
      headers: {'Content-Type'=> "application/json; charset=utf-8"},
      body: reqBody,
    )
    flightRequest.run
    @results = JSON.parse(flightRequest.response.body)
    @results['trips']['tripOption'].each do |trip|
      fare = trip['saleTotal'].slice(3, trip['saleTotal'].length).to_i
      if fare <= budget
        puts fare #and triggers email runner UserMailer.nightly_update.deliver_now(pass in user here i think)
      end
    end
    render nothing: true
    # respond_to do |format|
    #   format.html
    #   format.json { render json: {
    #     :results => @results
    #     }
    #   }
    # end
  end

  def save
    savedSearch = params[:savedSearch]
    @saved = Alert.create(
      uid:params[:uid],
      searchParams:savedSearch,
      origin:params[:origin],
      destination:params[:destination],
      departDate:params[:departDate],
      returnDate:params[:returnDate],
      adultCount:params[:adultCount],
      childCount:params[:childCount],
      maxPrice:params[:maxPrice],
      preferredCabin:params[:preferredCabin],
      permittedCarrier:params[:permittedCarrier],
      prohibitedCarrier:params[:prohibitedCarrier]
    )
    respond_to do |format|
      format.json { render json: @saved }
    end
  end

  def destroy
    alert = Alert.find params[:format]
    alert.delete
    redirect_to root_path
  end

private 
    def confirm_logged_in
      unless session[:user_id]
        redirect_to login_path, alert: "Please log in"
      end
    end
    


end

