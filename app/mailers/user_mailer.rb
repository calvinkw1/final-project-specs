class UserMailer < ApplicationMailer
  require 'mandrill'
  default from: 'getmeflights@gmail.com'
  @m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'

  def welcome_email(user)
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
       :from_name=>"Team @ getmeflights",
       :from_email=>"getmeflights@gmail.com"
      }
      sending = m.messages.send message  
      puts sending
  end

  def alert_email
    require 'mandrill'
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
       :from_name=>"Team at getmeflights",
       :from_email=>"getmeflights@gmail.com"
      }
      sending = m.messages.send message  
      puts sending
  end
  
  def admin_email
      require 'mandrill'
      m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA'
      user = User.all[0]
      searches = Alert.find_by_uid(user.id)
      binding.pry
      message = {  
        :tags =>["admin"],
         :subject=> "Admin Report",  
         :from_name=> "Team at getmeflights",  
         :text=>"Team @ getmeflights => ALERTS",
         :to=>[  {
             :email=> "designmarz@gmail.com",  
             :name=> "Nick"  
           }  
         ],  
         :html=>"TO BE REPLACED",  
         :from_email=>"getmeflights@gmail.com",
         :from_name=>"Team at getmeflights"
        
        }   
 message[:html] =
"<html>
        <h1>Admin Report</h1>
        <p>Hey " + user.first_name + user.last_name + "</p>" + "
        <p>Hard coding hash override in method<br> admin email</p>
        <p>" + user.email + "</p>
        <p>
<table>
  <thead>
    <tr>
    <td>Origin</td><td>Destination</td><td>Departure</td><td>Return</td><td>Adults</td><td>Children</td><td>Max Price</td><td>Cabin Class</td><td>Preferred Airlines</td>
    </tr>
  </thead>
  <tbody>
      <tr>
<td>" + searches.origin + "</td>
<td>" + searches.destination + "</td>
<td>" + searches.departDate + "</td>
<td>" + searches.returnDate + "</td>
<td>" + searches.adultCount.to_s + "</td>
<td>" + searches.childCount.to_s + "</td>
<td> $" + searches.maxPrice.to_s + "</td>
<td>" + searches.preferredCabin + "</td>
<td>" + searches.permittedCarrier[2..3] + "</td>
      </tr>
  </tbody>
</table>
</html>"
        binding.pry         
        sending = m.messages.send message  
        puts sending
        puts "sending admin email on the hourly" 
  end

  def nightly_update
  puts "nightly_update"
    users = User.all
    
    users.each do |user|
    searches = Alert.find_by_uid(user.id)
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
       :from_email=>"getmeflights@gmail.com"
      }
      message[:html] = "<html>
        <h1>getmeflights Updates!</h1>
        <p>Hey " + user.first_name + user.last_name + "</p>" + "
        <p>" + user.email + "</p>

        <p> <a href='https://www.google.com/flights/#search;f=" + searches.origin +
        ";t=" + searches.destination + ";d=" + searches.departDate + ";r=" + searches.returnDate + "'>We found your trip!</a></html>"
      binding.pry
      sending = m.messages.send message  
      puts sending
    end
  end
  

end
