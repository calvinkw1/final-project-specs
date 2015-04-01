module ApplicationHelper
  def alertSearch(user)
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
end
