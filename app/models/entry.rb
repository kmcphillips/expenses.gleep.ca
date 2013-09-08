class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :household
  belongs_to :category

  validates :user_id, presence: true
  validates :household_id, presence: true
  validates :category_id, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0, only_integer: true, message: "must be a positive number with the cents rounded off"}
  validates :incurred_on, presence: true

end
