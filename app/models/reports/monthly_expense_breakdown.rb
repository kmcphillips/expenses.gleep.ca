class Reports::MonthlyExpenseBreakdown
  attr_reader :household, :starts_on, :ends_on

  def initialize(household, year=nil, month=nil)
    @household = household

    month = month.to_i if month.present?
    year = Date.today.year unless year.present?
    year = year.to_i

    if month.present?
      @starts_on = Date.new(year, month)
      @ends_on = @starts_on.end_of_month
    else
      @starts_on = Date.new(year)
      @ends_on = @starts_on.end_of_year
    end
    
    @starts_on = [@starts_on, household.started_on].max
    @ends_on = [@ends_on, Date.today].min
  end

  def to_h
    {
      chart: { type: 'pie' },
      title: { text: '' },
      yAxis: {
        title: {
          text: ''
        }
      },
      plotOptions: {
        pie: {
          shadow: false,
          center: ['50%', '50%']
        }
      },
      tooltip: {
        valuePrefix: '$'
      },
      series: [inner_series, outer_series]
    }
  end

  private

  def inner_series
    {
      name: 'Categories',
      data: category_data,
      size: '50%',
      dataLabels: {
        # formatter: "function() { this.point.name; }",
        color: 'white',
        distance: -30
      }
    }
  end

  def outer_series
    {
      name: 'Expenses',
      data: expense_data,
      size: '80%',
      innerSize: '50%',
      dataLabels: {
        # formatter: "function() { '<b>' + this.point.name + ':</b> ' + this.y + '%'; }"
      }
    }
  end

  def category_data
    [
      {name: 'Essential', y: sum_amount(essential), color: "#A5D63B"},
      {name: 'Non-essential', y: sum_amount(non_essential), color: "#273D54"}
    ]
  end

  def expense_data
    results = []

    {"#8bbc21" => essential, "#0d233a" => non_essential}.each do |color, entries|
      entries.map(&:category).uniq.sort{|a,b| a.name <=> b.name}.each do |category|
        results << {name: category.name, y: sum_amount(entries.for_category(category)), color: color}
      end
    end

    results
  end

  def entries
    @entries ||= Entry.reportable(@household).where(incurred_on: @starts_on..@ends_on).expense
  end

  def essential
    @essential_entries ||= entries.essential
  end

  def non_essential
    @non_essential_entries ||= entries.non_essential
  end

  def total
    @total ||= [essential, non_essential].inject(0){|accu, rel| accu + rel.sum(:amount) }
  end

  def sum_amount(rel)
    # ((rel.sum(:amount).to_f / total) * 100).round(2)  # Percentage
    rel.sum(:amount)
  end

end
