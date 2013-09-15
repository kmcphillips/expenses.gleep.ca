class EntrySchedule < ActiveRecord::Base
  FREQUENCIES = [
    "monthly",
    "twice_monthly",
    "every_two_weeks",
    "quarterly",
    "yearly"
  ]
  
  belongs_to :category
  belongs_to :household

  has_many :entries

  validates :name, presence: true
  validates :category_id, presence: true
  validates :household_id, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0, message: "must be a positive number"}
  validates :frequency, presence: true, inclusion: FREQUENCIES
  validates :starts_on, presence: {if: ->(es) { es.frequency != 'twice_monthly'}}

  scope :active, -> { where(active: true) }

  def current_period
    period_for Date.today
  end

  def period_for(date)
    PeriodCalculator.new(date, frequency, starts_on).period
  end

  def applies_today?
    active? && current_period.try(:first) == Date.today
  end

  private

  class PeriodCalculator
    attr_reader :date, :starts_on

    def initialize(date, frequency, starts_on)
      raise "Unknown frequency '#{ frequency }'" unless EntrySchedule::FREQUENCIES.include?(frequency)

      @date = date
      @frequency = frequency
      @starts_on = starts_on
    end

    def period
      return nil if starts_on.present? && date < starts_on
      send(@frequency)
    end

    private

    def monthly
      to = starts_on
      offset_months = 0
      offset_months += 1 until (to + offset_months.months) > date

      from = to + (offset_months - 1).months
      to = (from + 1.month) - 1.day

      from..to
    end

    def twice_monthly
      if date.day < 15
        date.beginning_of_month..Date.new(date.year, date.month, 14)
      else
        Date.new(date.year, date.month, 15)..date.end_of_month
      end
    end

    def every_two_weeks
      to = starts_on
      to += 14.days until to > date
      (to - 14.days)..(to - 1.day)
    end

    def quarterly
      to = starts_on
      offset_quarters = 0
      offset_quarters += 1 until (to + (offset_quarters * 3).months) > date

      from = to + ((offset_quarters - 1) * 3).months
      to = (from + 3.months) - 1.day

      from..to
    end

    def yearly
      to = starts_on
      to += 1.year until to > date
      (to - 1.year)..(to - 1.day)
    end

  end

end
