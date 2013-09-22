class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :household
  belongs_to :category
  belongs_to :entry_schedule

  has_many :amortized_entries

  validates :household_id, presence: true
  validates :category_id, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0, message: "must be a positive number"}
  validates :incurred_on, presence: true
  validate :incurred_until_range

  after_save :create_amortized_entries
  before_validation :set_household

  scope :sorted, -> { order("incurred_on DESC") }
  scope :for_category, ->(category_id) { where(category_id: category_id) }
  scope :expense, -> { includes(:category).where("categories.income = ?", false).references(:categories) }
  scope :income, -> { includes(:category).where("categories.income = ?", true).references(:categories) }
  scope :savings, -> { includes(:category).where("categories.category_type = ?", "savings").references(:categories) }
  scope :except_savings, -> { includes(:category).where("categories.category_type != ?", "savings").references(:categories) }
  scope :scheduled, -> { where("entry_schedule_id IS NOT NULL") }
  scope :this_month, -> { where("incurred_on BETWEEN ? AND ?", Date.today.beginning_of_month, Date.today.end_of_month) }
  scope :last_month, -> { 
    date = Date.today - 1.month
    where("incurred_on BETWEEN ? AND ?", date.beginning_of_month, date.end_of_month)
  }
  scope :unique, -> { where(entry_id: nil) }
  scope :reportable, ->(household) { unique.where(household_id: household.id, incurred_on: (household.started_on..Date.today)) }
  scope :year, ->(year) { where(incurred_on: (Date.new(year)..Date.new(year).end_of_year)) }

  def amortized?
    incurred_until.present?
  end

  def amortized_days
    if amortized?
      (incurred_until - incurred_on).to_i + 1
    end
  end

  def create_amortized_entries
    if amortized?
      ActiveRecord::Base.transaction do
        amortized_entries.destroy_all

        amortized_amount = (amount.to_f / amortized_days)

        (incurred_on..incurred_until).each do |date|
          self.amortized_entries.create!(
            user: user,
            household: household,
            category: category,
            description: description,
            amount: amortized_amount,
            incurred_on: date
          )
        end
      end
    end
  end

  private

  def incurred_until_range
    if incurred_until && incurred_on && incurred_until <= incurred_on
      errors.add :incurred_until, "must be after the incurred date"
    end
  end

  def set_household
    household = user.household if user && !household
  end

end
