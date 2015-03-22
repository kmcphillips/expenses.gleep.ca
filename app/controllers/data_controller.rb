class DataController < AuthenticatedController

  def index
    redirect_to yearly_breakdown_data_path
  end

  def yearly_totals
    @totals = Reports::YearlyTotals.new(current_household, params[:year] || Date.today.year)
  end

  def yearly_breakdown
    @report = Reports::YearlyBreakdown.new(current_household, params[:year] || Date.today.year)
  end

  def car
    @car = Reports::Car.new(current_household, params[:year] || Date.today.year)
  end

  def monthly_expense_income
    @chart = Reports::MonthlyExpenseIncome.new(current_household)
  end

  def expense_breakdown
    @chart = Reports::ExpenseBreakdown.new(current_household, params[:year], params[:month])
  end

end
