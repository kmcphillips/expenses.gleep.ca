class Reports::YearlyTotals < Reports::YearlyBase

  def total_income
    @total_income ||= entries.except_savings.income.sum(:amount)
  end

  def total_expenses
    @total_expenses ||= entries.except_savings.expense.sum(:amount)
  end

  def total_balance
    total_income - total_expenses
  end

  def total_from_savings
    savings["Total"]
  end

  def projections
    @projections ||= Projections.new(self)
  end

  def savings
    return @savings if @savings

    @savings = {"Total" => entries.savings.sum(:amount) }
    Category.only_savings.each do |category|
      @savings[category.name.gsub("(Savings)", "")] = entries.savings.where(category_id: category.id).sum(:amount)
    end

    @savings
  end

  private

  class Projections
    attr_reader :totals
    delegate :year, :household, to: :totals

    def initialize(totals)
      @totals = totals
    end

    def daily
      @daily ||= OpenStruct.new(
        income: (totals.total_income / totals.number_of_days),
        expenses: (totals.total_expenses / totals.number_of_days),
        balance: (totals.total_balance / totals.number_of_days)
      )
    end

    def monthly
      @monthly ||= OpenStruct.new(
        income: daily.income * 30,
        expenses: daily.expenses * 30,
        balance: daily.balance * 30
      )
    end

    def yearly
      @yearly ||= OpenStruct.new(
        income: daily.income * 365,
        expenses: daily.expenses * 365,
        balance: daily.balance * 365
      )
    end
  end

end
