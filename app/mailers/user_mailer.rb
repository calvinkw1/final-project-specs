class UserMailer < ApplicationMailer
  require 'mandrill'
  default from: 'getmeflights@gmail.com'
  @m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'

  def welcome_email(user)
    # require 'mandrill'
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
       :from_name=>"Team @ getmeflights",
       :from_email=>"<getmeflights@gmail.com>"
      }
      sending = m.messages.send message  
      puts sending
  end

  def alert_email
    # require 'mandrill'
    m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'
    # user = User.all[0]
    message = {  
       :subject=> "Hourly Alerts!",  
       :from_name=> "Team at getmeflights",  
       :text=>"Team @ getmeflights => ALERTS",
       :to=>[  {
           :email=> "designmarz@gmail.com",  
           :name=> "Nick"  
         }  
       ],  
       :html=>"<html><h1>Hourly Alert Test</h1></html>",  
       :from_email=>"getmeflights@gmail.com",
       :from_name=>"Team at getmeflights"
      
      }  
      sending = m.messages.send message  
      puts sending
    
  end
  def testing
    puts "Testing!"
  end

  def email_name
    require 'mandrill'
    m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'
    user = User.all[0]
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
       :from_name=>"Team @ getmeflights",
       :from_email=>"<getmeflights@gmail.com>"
      }  
      sending = m.messages.send message  
      puts sending
  end
  
  def admin_email
      # require 'mandrill'
      m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'
      # @user = User.all[0]
      message = {  
         :subject=> "Admin Report",  
         :from_name=> "Team at getmeflights",  
         :text=>"Team @ getmeflights => ALERTS",
         :to=>[  {
             :email=> "designmarz@gmail.com",  
             :name=> "Nick"  
           }  
         ],  
         :html=>"<html><h1>Admin Report</h1>
         <p>#{@user}</p> </html>",  
         :from_email=>"getmeflights@gmail.com",
         :from_name=>"Team at getmeflights"
        
        }  

        sending = m.messages.send message  
        puts sending
        puts "sending admin email on the hourly" 
  end

  def nightly_update

    users = User.all
    users.each do |user|
    require 'mandrill'
    m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'
    
    message = {  
       :subject=> "Your Flight Alerts!",  
       :from_name=> "Team @ getmeflights",
       :text=>"Nightly Update #{user.first_name}",
       :to=>[  {
           :email=> user.email,  
           :name=> user.first_name  
         }  
       ],  
       :html=>"<html><h1>Hi <strong>message</strong>, how are you?</h1></html>",  
       :from_name=>"Team @ getmeflights",
       :from_email=>"<getmeflights@gmail.com>"
      }  
      sending = m.messages.send message  
      puts sending
    end
  end
  

end
