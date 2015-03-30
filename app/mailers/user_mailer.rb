class UserMailer < ApplicationMailer
  require 'mandrill'
  default from: 'flightTest@gmail.com'
  @m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'

  def welcome_email(user)
    binding.pry
    require 'mandrill'
    m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'
    message = {  
       :subject=> "Thanks for signing up!",  
       :from_name=> "#{user.email}",  
       :text=>"ALERTS",
       :to=>[  {
           :email=> user.email,
           :name=> user.first_name  
         }  
       ],  
       :html=>"<html><h1>Thanks for signing up!</h1></html>",  
       :from_email=>user.email
      }  
      sending = m.messages.send message  
      puts sending
  end

  def alert_email
    
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
       :to=>[  {
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

  

end
