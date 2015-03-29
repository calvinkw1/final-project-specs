require 'mandrill'

class UserMailer < ApplicationMailer
 default from: 'flightTest@gmail.com'
 m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'

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
  
  def email_name
    require 'mandrill'
m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'
    user = User.all[0]
    binding.pry
    message = {  
       :subject=> "Your Flight Alerts!",  
       :from_name=> "#{user.email}",  
       :text=>"ALERTS",
       :to=>[  
         {  
           :email=> user.email,  
           :name=> user.first_name  
         }  
       ],  
       :html=>"<html><h1>Hi <strong>message</strong>, how are you?</h1></html>",  
       :from_email=>user.email
      }  
      sending = m.messages.send message  
      puts sending
  end



   def index
      render :file => 'app\views\emailer\index.rhtml'
   end

       # emails.map {|email|{email:email,name:"Friend"}}


    # mail(subject: "Mandrill rides the Rails!",
    #      to:      user.email,
    #      from:    user.email).deliver



  

end
