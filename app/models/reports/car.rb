class Reports::Car < Reports::YearlyBase

  def categories
    @categories ||= begin
      household.categories.where(name: [
        "Car Insurance",
        "Car",
        "Gas"
      ]).to_a
    end
  end

  def car_entries
    entries.year(@year).for_category(categories)
  end

  def total_cost
    car_entries.sum(:amount)
  end

  def average_daily_cost
    total_cost.to_f / number_of_days
  end

  def average_monthly_cost
    average_daily_cost * (365 / 12)
  end

  def cost_per_category
    unless @cost_per_category
      @cost_per_category = {}

      categories.each do |category|
        @cost_per_category[category.name] = car_entries.for_category(category).sum(:amount)
      end
    end

    @cost_per_category
  end

end
