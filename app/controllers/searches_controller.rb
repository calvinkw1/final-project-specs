class SearchesController < ApplicationController
  def index
    Flightsearch_worker.delay_for(1.minute)
  end
end
