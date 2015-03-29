require 'sidekiq'
class Flightsearch_worker
  include Sidekiq::Worker

  def perform(count)
    puts "Job ##{count}: Late night, so tired..."
  end

  def self.late_night_work
    10.times do |x|
      perform_async(x)
    end
  end
end

# # Kick off a bunch of jobs early in the morning
# every 1.day, :at => '1:00 pm' do
#   runner "MyWorker.late_night_work"
#   end
