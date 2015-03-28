class UserMailer < ApplicationMailer
 default from: 'flightTest@gmail.com'

  def welcome_email(user)
    @user = user
    binding.pry
    @url = 'http://localhost:3000'
    mail(@user.email, subject: "Welcome Email")
  end

  def alert_email
    @user = user
    @url = 'http://localhost:3000'
    mail(@user.email, subject: "Your Flight Alerts")
  end

end
