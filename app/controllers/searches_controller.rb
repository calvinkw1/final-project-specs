class SearchesController < ApplicationController
  # before_action :confirm_logged_in
  # before_action :prevent_login_signup, only: [:signup, :login]
  require 'json'

  def index
  end

  def new
    reqBody = params[:qpxData]
    flightRequest = Typhoeus::Request.new(
      "https://www.googleapis.com/qpxExpress/v1/trips/search?key=" + ENV["QPX_API_KEY"],
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
    users = User.all
    users.each do |user|
      searches = Alert.where("uid = ?", user.id).limit(2)
      searches.each do |search|
        reqBody = search.searchParams.to_s
        maxPrice = search.maxPrice
        # params[:qpxData] # pass in the stringified json obj here from the alerts table
        budget = maxPrice.slice(3, maxPrice.length).to_i
        flightRequest = Typhoeus::Request.new(
          "https://www.googleapis.com/qpxExpress/v1/trips/search?key=" + ENV["QPX_API_KEY"],
          method: :post,
          headers: {'Content-Type'=> "application/json; charset=utf-8"},
          body: reqBody,
        )
        flightRequest.run
        @results = JSON.parse(flightRequest.response.body)
        @results['trips']['tripOption'].each do |trip|
          fare = trip['saleTotal'].slice(3, trip['saleTotal'].length).to_i
          if fare <= budget
            search.update_attributes search: true
            puts fare #and triggers email runner UserMailer.nightly_update.deliver_now(pass in user here i think)
          else 
            search.update_attributes search: false
          end
        end
      end
    end
    render nothing: true
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

