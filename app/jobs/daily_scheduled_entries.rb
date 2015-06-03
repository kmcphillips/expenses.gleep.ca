class DailyScheduledEntries
  attr_reader :date, :households

  def initialize(opts={})
    @date = opts[:date] || Date.today
    @households = [opts[:household] || opts[:households] || Household.active].flatten
  end

  def run
    if households.any?
      households.each do |household|
      Rails.logger.info("[DailyScheduledEntries] Processing household #{ household }")

        household.entry_schedules.active.each do |entry_schedule|
          begin
            if entry_schedule.applies_on? date
              entry = entry_schedule.build_entry(date)
              entry.save!

              Rails.logger.info("[DailyScheduledEntries] Added entry #{ entry.inspect } from schedule #{ entry_schedule.inspect }")
            end
          rescue => e
            Rails.logger.error("[DailyScheduledEntries] ERROR: Failed to apply scheduled entry #{ entry_schedule.inspect }")
            Rails.logger.error(e.message)
            Rails.logger.error(e)
          end
        end
      end
    else
      Rails.logger.info("[DailyScheduledEntries] No active households")
    end
  end

end
