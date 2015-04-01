
every 1.day, :at => "4:15pm" do
  runner "UserMailer.nightly_update.deliver_now"
end

every 1.day, :at => "4:10pm" do
  runner "SearchesController.alertSearch"
end



every 1.minutes do #change time to 15 minutes
 command "cd /Users/NickMarazzo/Desktop/final-project-specs/ && whenever -i" #need to get thsi working
 puts "ran whenever update"
  # runner "UserMailer.admin_email.deliver_now" #remove this
end










