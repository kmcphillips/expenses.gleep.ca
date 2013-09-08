class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :household
  belongs_to :category

  validates :user_id, presence: true
  validates :household_id, presence: true
  validates :category_id, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0, only_integer: true, message: "must be a positive number with the cents rounded off"}
  validates :incurred_on, presence: true

  scope :sorted, -> { order("incurred_on DESC") }
  scope :for_category, ->(category_id) { where(category_id: category_id) }
  scope :expense, -> { includes(:category).where("categories.income = ?", false) }
  scope :income, -> { includes(:category).where("categories.income = ?", true) }
  scope :this_month, -> { where("incurred_on BETWEEN ? AND ?", Date.today.beginning_of_month, Date.today.end_of_month) }
  scope :last_month, -> { 
    date = Date.today - 1.month
    where("incurred_on BETWEEN ? AND ?", date.beginning_of_month, date.end_of_month)
  }

end
