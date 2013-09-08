class Household < ActiveRecord::Base
  has_many :users
  has_many :categories
  has_many :authorized_emails
  has_many :entries

  validates :name, presence: true

  def categories_for_select
    { 
      "" => [nil],
      "Expenses" => categories.active.expense.sorted.map{|c| [c.name, c.id]},
      "Income" => categories.active.income.sorted.map{|c| [c.name, c.id]}
    }
  end
end
