class Reports::YearlyBase
  attr_reader :year, :household

  def initialize(household, year)
    @year = year.to_i
    @household = household
  end

  protected

  def entries
    @entries ||= Entry.reportable(@household)
  end

end
