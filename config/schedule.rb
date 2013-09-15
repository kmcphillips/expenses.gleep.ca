Time.zone = "US/Central"

every 1.day, at: "3am" do
  rake 'jobs:daily_scheduled_entries'
end
