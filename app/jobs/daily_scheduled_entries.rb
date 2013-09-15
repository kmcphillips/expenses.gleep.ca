class DailyScheduledEntries
  attr_reader :date, :households

  def initialize(opts={})
    @date = opts[:date] || Date.today
    @households = [opts[:household] || opts[:households] || Household.all].flatten
  end

  def run
    households.each do |household|
      household.entry_schedules.active.each do |entry_schedule|
        begin
          if entry_schedule.applies_on? date
            entry = entry_schedule.build_entry(date)
            entry.save!

            Rails.logger.info("Added entry #{ entry.inspect } from schedule #{ entry_schedule.inspect }")
          end
        rescue => e
          Rails.logger.error("ERROR: Failed to apply scheduled entry #{ entry_schedule.inspect }")
          Rails.logger.error(e.message)
          Rails.logger.error(e)
        end
      end
    end
  end

end
