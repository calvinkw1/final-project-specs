require 'sidekiq'
class Flightsearch_worker
  include Sidekiq::Worker

  def perform(count)
    puts "Job ##{count}: Late night, so tired..."
  end

  def nightly_search(user)
    # add logic to run searchs for all users here
  end

end