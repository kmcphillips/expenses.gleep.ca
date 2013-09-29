class DataController < AuthenticatedController

  def index
    @totals = Reports::YearlyTotals.new(current_household, 2013)
  end

  def monthly_expense_income
    @chart = Reports::MonthlyExpenseIncome.new(current_household)
  end

  def monthly_expense_breakdown
    @chart = Reports::MonthlyExpenseBreakdown.new(current_household, params[:year], params[:month])
  end

end
