class DataController < AuthenticatedController

  def index
    @totals = Reports::YearlyTotals.new(current_household, params[:year] || Date.today.year)
  end

  def monthly_expense_income
    @chart = Reports::MonthlyExpenseIncome.new(current_household)
  end

  def expense_breakdown
    @chart = Reports::ExpenseBreakdown.new(current_household, params[:year], params[:month])
  end

end
