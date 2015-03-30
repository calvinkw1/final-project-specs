class SearchesController < ApplicationController
  # before_action :confirm_logged_in
  # before_action :prevent_login_signup, only: [:signup, :login]
  require 'json'

  def index
   @user = User.all
    Flightsearch_worker.perform_in(1.minutes, 2)
    # UserMailer.email_name.deliver
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
    @saved = Alert.create(searchParams:savedSearch)
    binding.pry
    redirect_to users_main_path
  end

private 
    def confirm_logged_in
      unless session[:user_id]
        redirect_to login_path, alert: "Please log in"
      end
    end
    
end

