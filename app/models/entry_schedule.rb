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

  scope :active, -> { where(active: true) }

  def current_period
    period_for Date.today
  end

  def period_for(date)
    case frequency
    when 'monthly'

      # starts_on.day == today.day || (today.end_of_month && starts_on.day > today.day)
    when 'twice_monthly'
      if date.day < 15
        date.beginning_of_month..Date.new(date.year, date.month, 14)
      else
        Date.new(date.year, date.month, 15)..date.end_of_month
      end
    when 'every_two_weeks'
      # (starts_on - today).to_i % 14 == 0
    when 'quarterly'

    when 'yearly'
      
    else
      raise "Unkown frequency '#{ frequency }'"
    end
  end

  def applies_today?
    active? && current_period.first == Date.today
  end

end
