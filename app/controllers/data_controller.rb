class DataController < AuthenticatedController

  def index
    @totals = Reports::YearlyTotals.new(current_household, 2013)
  end

end
