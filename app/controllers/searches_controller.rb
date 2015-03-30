class SearchesController < ApplicationController
  require 'json'

  def index
 
  end

  def new
    # origin = params[:origin]
    # destination = params[:destination]
    # date = params[:date]
    # adultCount = params[:adultCount]
    # permittedCarrier = params[:permittedCarrier]
    # preferredCabin = params[:preferredCabin]
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

end

