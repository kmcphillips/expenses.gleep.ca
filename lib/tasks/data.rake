namespace :data do

  desc "Imports spreadsheet from csv file passed as CSV=path/to/file.csv and HOUSEHOLD_ID=1"
  task import_from: :environment do
    ImportFromCsv.new(ENV["CSV"], Household.find(ENV["HOUSEHOLD_ID"])).run
  end

  desc "Runs all the scheduled expenses from the household start date until today"
  task run_all_schedules: :environment do
    household = Household.find(ENV["HOUSEHOLD_ID"])

    (household.started_on..Date.today).each do |date|
      household.entry_schedules.active.each do |entry_schedule|
        if entry_schedule.applies_on? date
          entry = entry_schedule.build_entry(date)

          puts [entry.category.name, entry.description, "on", entry.incurred_on, "$#{ entry.amount }"].join(" ")

          entry.save!
        end
      end
    end
  end

end
