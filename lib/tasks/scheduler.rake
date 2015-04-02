namespace :scheduler do
  desc "TODO"
  task search_alerts: :environment do
    SearchesController.alertSearch
  end

  desc "TODO"
  task match_found_email: :environment do
    UserMailer.nightly_update
  end

end
