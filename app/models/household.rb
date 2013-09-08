class Household < ActiveRecord::Base
  has_many :users
  has_many :categories
  has_many :authorized_emails

  validates :name, presence: true

end
