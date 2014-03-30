class Reports::YearlyBreakdown < Reports::YearlyBase

  def income
    @income ||= months.map{|month| entries_for_month(month).income.sum(:amount) }
  end

  def expenses_by_type
    return @expenses_by_type if @expenses_by_type

    @expenses_by_type = {}

    Category.expense.without_savings.sorted.each do |category|
      @expenses_by_type[category.name] = []

      months.each do |month|
        @expenses_by_type[category.name] << entries_for_month(month).for_category(category).sum(:amount) * -1
      end
    end

    @expenses_by_type
  end

  def from_savings_by_type
    return @from_savings_by_type if @from_savings_by_type

    @from_savings_by_type = {}

    Category.only_savings.sorted.each do |category|
      category_name = category.name.gsub(" (Savings)", "")
      @from_savings_by_type[category_name] = []

      months.each do |month|
        @from_savings_by_type[category_name] << entries_for_month(month).for_category(category).sum(:amount) * -1
      end
    end

    @from_savings_by_type
  end

  def total_expenses
    return @total_expenses if @total_expenses

    @total_expenses = []

    (0..11).each do |month|
      @total_expenses[month] = 0
      (expenses_by_type.values + from_savings_by_type.values).each do |row|
        @total_expenses[month] += row[month]
      end
    end

    @total_expenses
  end

  def total_balance
    (0..11).map do |month|
      income[month] + total_expenses[month]
    end
  end

  private

  def months
    1..12
  end

  def entries_for_month(month)
    entries.month(year, month)
  end

end
