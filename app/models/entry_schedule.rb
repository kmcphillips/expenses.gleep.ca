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

  def applies_today?
    return false unless active?

    today = Date.today

    case frequency
    when 'monthly'
      starts_on.day == today.day || (today.end_of_month && starts_on.day > today.day)
    when 'twice_monthly'
      today.day == 1 || today.day == 15
    when 'every_two_weeks'
      (starts_on - today).to_i % 14 == 0
    when 'quarterly'

    when 'yearly'
      today.day == starts_on.day && today.month == starts_on.month
    else
      raise "Unkown frequency '#{ frequency }'"
    end
  end

end
