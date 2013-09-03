class Category < ActiveRecord::Base
  belongs_to :household

  validates :name, presence: true, uniqueness: {scope: :household_id}
  validates :household, presence: true

  scope :income, where(income: true)
  scope :expense, where(income: false)
  scope :active, where(active: true)
end
