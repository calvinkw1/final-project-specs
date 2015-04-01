# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 1.day, :at => "10:25pm" do
  runner "UserMailer.admin_email.deliver_now"
end

# FOR TESTING ONLY CHANGE TIME ONCE CONFIRMED
every 1.day, :at => "10:25am" do
  runner "UserMailer.nightly_update.deliver_now"
end

every 1.hour do
  runner "UserMailer.alert_email.deliver_now"
end

# FOR TESTING ONLY REMOVE ONCE CONFIRMED
every 1.minutes do #change time to 15 minutes
 command "whenever -i" #need to get thsi working
 puts "ran whenever update"
  # runner "UserMailer.admin_email.deliver_now" #remove this
end

