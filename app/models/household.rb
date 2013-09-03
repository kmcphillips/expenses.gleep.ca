class Household < ActiveRecord::Base
  has_many :users
  has_many :categories

  validates :name, presence: true

end
