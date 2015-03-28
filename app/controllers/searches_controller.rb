class SearchesController < ApplicationController
  def index
    Flightsearch_worker.delay_for(1.minute)
    UserMailer.welcome_email("Nick")
  end
end
