require 'mandrill'
class UserMailer < ApplicationMailer
 default from: 'flightTest@gmail.com'

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(@user.email, subject: "Welcome Email")
  end

  def alert_email
    user = User.all[0]
    binding.pry
    # @user = User.find(params[:id] = 1)
    @url = 'http://localhost:3000'
    binding.pry
    mail(to: user.email, subject: "Your Flight Alerts")
  end

   def sendmail
      email = params["email"]
     recipient = email["recipient"]
     subject = email["subject"]
     message = email["message"]
      mailer=Emailer.contact(recipient, subject, message)
      mailer.deliver
      return if request.xhr?
        render :text => 'Message sent successfully'
   end


   def index
      render :file => 'app\views\emailer\index.rhtml'
   end

  

end
