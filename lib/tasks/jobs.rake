namespace :jobs do

  desc "Apply daily scheduled entries"
  task daily_scheduled_entries: :environment do
    DailyScheduledEntries.new.run
  end

end
