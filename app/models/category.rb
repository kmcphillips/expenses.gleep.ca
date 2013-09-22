class Category < ActiveRecord::Base
  TYPES = ["essential", "non-essential", "savings"]

  belongs_to :household

  validates :name, presence: true, uniqueness: {scope: :household_id}
  validates :household, presence: true
  validates :category_type, presence: true, inclusion: {in: TYPES}
  validate :savings_only_expenses

  scope :income, -> { where(income: true) }
  scope :expense, -> { where(income: false) }
  scope :active, -> { where(active: true) }
  scope :sorted, -> { order("name ASC") }
  scope :without_savings, -> { where("category_type != ?", 'savings') }
  scope :only_savings, -> { where("category_type = ?", 'savings') }

  scope :select_expenses, -> { active.expense.without_savings.sorted }
  scope :select_income, -> { active.income.without_savings.sorted }
  scope :select_savings, -> { active.only_savings.sorted }

  def essential?
    category_type == "essential"
  end

  private

  def savings_only_expenses
    errors.add(:income, "must be false for type 'savings'") if category_type == "savings" && income
  end

end
