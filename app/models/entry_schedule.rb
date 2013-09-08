class EntrySchedule < ActiveRecord::Base
  belongs_to :category
  belongs_to :household

  has_many :entries

  validates :name, presence: true
  validates :category_id, presence: true
  validates :household_id, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0, message: "must be a positive number"}
  validates :frequency, presence: true

  scope :active, -> { where(active: true) }


end
