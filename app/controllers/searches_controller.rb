class SearchesController < ApplicationController
  def index
    @user = User.all
    Flightsearch_worker.perform_in(1.minutes, 5)
    binding.pry
    # User_Mailer.alert_email.deliver
    UserMailer.alert_email.deliver
  end
end