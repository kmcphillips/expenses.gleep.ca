namespace :data do

  desc "Imports spreadsheet from csv file passed as CSV=path/to/file.csv and HOUSEHOLD_ID=1"
  task import_from: :environment do
    ImportFromCsv.new(ENV["CSV"], Household.find(ENV["HOUSEHOLD_ID"])).run
  end

end
