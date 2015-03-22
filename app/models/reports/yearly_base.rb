class Reports::YearlyBase
  attr_reader :year, :household

  def initialize(household, year)
    @year = year.to_i
    @household = household
  end

  def number_of_days
    @number_of_days ||= begin
      start_date = [Date.new(year), household.started_on].max
      end_date = [Date.new(year).end_of_year, Date.today].min

      (end_date - start_date).to_i
    end
  end

  protected

  def all_entries
    @entries ||= Entry.reportable(household)
  end

  def entries
    all_entries.year(year)
  end

end
