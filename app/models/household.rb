class Household < ActiveRecord::Base
  has_many :users
  has_many :categories
  has_many :authorized_emails
  has_many :login_tokens
  has_many :entries
  has_many :entry_schedules

  validates :name, presence: true
  validates :started_on, presence: true

  scope :active, ->{ where(active: true) }

  def categories_for_select
    {
      "Expenses" => categories.select_expenses.map{|c| [c.name, c.id]},
      "Income" => categories.select_income.map{|c| [c.name, c.id]},
      "Savings" => categories.select_savings.map{|c| [c.name, c.id]}
    }
  end

  def applicable_years
    (started_on.year..Date.today.year).to_a.reverse
  end

  def recent_entry
    @recent_entry ||= entries.unique.order('created_at DESC').first
  end

end
