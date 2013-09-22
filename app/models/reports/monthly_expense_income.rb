class Reports::MonthlyExpenseIncome
  attr_reader :household

  def initialize(household)
    @household = household
  end

  def to_h
    {
      chart: { type: 'column' },
      title: { text: '' },
      xAxis: { categories: months.map{|d| d.to_s(:month_year)} },
      yAxis: {
        allowDecimals: true,
        min: 0,
        title: {
          text: ''
        }
      },
      tooltip: {
        formatter: "" # "function() { return this.series.name +': '+ this.y +' of '+ this.point.stackTotal; }"
      },
      plotOptions: {
        column: { stacking: 'normal' }
      },
      series: data
    }
  end

  private

  def months
    return @months if @months

    current = household.started_on.beginning_of_month
    @months = [current]

    while (current + 1.month) <= Date.today
      current += 1.month
      @months << current
    end

    @months
  end

  def data
    [
      {name: "Savings expenses", stack: "expenses", data: data_savings},
      {name: "Expenses", stack: "expenses", data: data_expenses},
      {name: "Essential expense", stack: "expenses", data: data_essential},
      {name: "Income", stack: "income", data: data_income}
    ]
  end

  def data_essential
    months.map do |started_on|
      entries.expense.essential.where(incurred_on: (started_on...(started_on + 1.month))).sum(:amount)
    end
  end

  def data_expenses
    months.map do |started_on|
      entries.expense.non_essential.where(incurred_on: (started_on...(started_on + 1.month))).sum(:amount)
    end
  end

  def data_savings
    months.map do |started_on|
      entries.savings.where(incurred_on: (started_on...(started_on + 1.month))).sum(:amount)
    end
  end

  def data_income
    months.map do |started_on|
      entries.income.where(incurred_on: (started_on...(started_on + 1.month))).sum(:amount)
    end
  end

  def entries
    @entries ||= Entry.reportable(@household)
  end

end
