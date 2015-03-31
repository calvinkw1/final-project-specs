class SearchesController < ApplicationController
  # before_action :confirm_logged_in
  # before_action :prevent_login_signup, only: [:signup, :login]
  require 'json'

  def index
   @user = User.all
    Flightsearch_worker.perform_in(1.minutes, 2)
    UserMailer.admin_email.deliver_now
    # UserMailer.nightly_update.deliver_now

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
    redirect_to root_path
  end

private 
    def confirm_logged_in
      unless session[:user_id]
        redirect_to login_path, alert: "Please log in"
      end
    end
    


end

