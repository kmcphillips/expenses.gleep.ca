class Reports::YearlyBreakdown
  attr_reader :year, :household

  def initialize(household, year)
    @year = year.to_i
    @household = household
  end


end
