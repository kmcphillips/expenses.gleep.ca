class DataController < AuthenticatedController

  def index
    @totals = Reports::YearlyTotals.new(current_household, 2013)
  end

  def monthly_expense_income
    @chart = Reports::MonthlyExpenseIncome.new(current_household).to_h
  end

end
