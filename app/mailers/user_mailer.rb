class UserMailer < ApplicationMailer
  include ApplicationHelper
  require 'mandrill' # wondering still if I need all the requires?
  default from: 'getmeflights@gmail.com'
  @m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA' # remove?

  def welcome_email(user)
    require 'mandrill'
    m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA' # add ENV keys with refreshed keys, do not use these
    message = {  
       :subject=> "Thanks for signing up!",  
       :from_name=> "getmeflights@gmail.com",  
       :text=>"Thanks for signing up!",
       :to=>[  {
           :email=> user.email,
           :name=> user.first_name  
         }  
       ],  
       :html=>"<html><h1>Thanks for signing up!</h1></html>",  # add styling here
       :from_name=>"Team @ getmeflights",
       :from_email=>"getmeflights@gmail.com"
      }
  message[:html] = "<!DOCTYPE html>
<html lang='en'>
<body>
<head>
  <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
</head>
<body>
<h1>Welcome to getMeFlights " + user.first_name + "!</h1>
  <p>
    You have successfully signed up to getMeFlights.com, <br>
    use " + user.email + " to login.
  </p>
<p>
  To login to the site, just follow this link <a href='heroku.com/getmeflights'>to login</a>
</p>
</body>
</html>"

      sending = m.messages.send message  
      puts sending
  end

  def alert_email # add field for logged in user, or remove maybe?
    require 'mandrill'
    m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA' # add ENV keys with refreshed keys, do not use these
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
  
  def email_name
    require 'mandrill'
    m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA' # add ENV keys with refreshed keys, do not use these
    user = User.all[0]
    message = {  
       :subject=> "Your Flight Alerts!",  
       :from_name=> "getmeflights@gmail.com",  
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
      m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA' # add ENV keys with refreshed keys, do not use these
      user = User.all[0]
      searches = Alert.find_by_uid(user.id)

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
                      </table> </p>
                    </html>"
            sending = m.messages.send message  
            puts sending
            puts "sending admin email on the hourly" 
  end

  def self.nightly_update
    users = User.all
    users.each do |user|
    searches = Alert.find_by_uid(user.id)
    # searches = Alert.where(uid:?, user.id)
    # if check to see run the search and check the pricing before
    # moving on to emailing the user of the updates
    
      if searches.search
        
        require 'mandrill'
        m = Mandrill::API.new 'ubbYv6wDtJu5N_4lHfJTdA' # add ENV keys with refreshed keys, do not use these
        message = {  
           :subject=> "Your Flight Alerts!",  
           :from_name=> "Team @ getmeflights",
           :text=>"Your flights update #{user.first_name}",
           :to=>[  {
               :email=> user.email,  
               :name=> user.first_name  
             }  
           ],  
           :html=>"TO BE REPLACED",  
           :from_name=>"Team @ getmeflights",
           :from_email=>"getmeflights@gmail.com"
          } # override the defualt html section with dynamic information on searches
          message[:html] = "<html> <body>
            <h1>getmeflights Updates!</h1>
            <p>Hey " + user.first_name + " we found your flight!</p>
            <p> Click below to find them now </p>
            <p> <a href='https://www.google.com/flights/#search;f=" + searches.origin +
            ";t=" + searches.destination + ";d=" + searches.departDate + ";r=" + searches.returnDate + "'>We found your trip!</a>
            <body></html>"
           # look into including img & css inline #remove 
          sending = m.messages.send message  
          puts sending
      end
    end
  end

end
