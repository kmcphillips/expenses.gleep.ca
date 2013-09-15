class ImportFromCsv
  attr_reader :rows, :household

  def initialize(filename, household)
    @rows = parse(filename)
    @household = household
  end

  def run
    count = 0
    skipped = []

    begin
      ActiveRecord::Base.transaction do
        rows.each_with_index do |row, index|
          if index != 0
            date, category_name, description, expense_amount, income_amount, _ = row.to_a
            category_name = (category_name || '').squish

            if importable?(category_name)
              count += 1

              entry = household.entries.build(
                category: category(category_name),
                description: description,
                amount: amount(expense_amount.presence || income_amount),
                incurred_on: date
              )

              entry.save!
            else
              skipped << [date, category_name, description, (expense_amount.presence || income_amount)]
            end
          end
        end
      end
    rescue => e
      puts "** Error. Transaction rolled back."
      puts e
    end

    puts "** Imported #{ count } rows"
    puts ""
    puts "** Skipped: "
    skipped.sort_by{|row| row[0] }.sort_by{|row| row[1] }.each do |row|
      row[1] = "(Income)" unless row[1].present?
      puts row.join(", ")
    end
  end

  private

  def parse(filename)
    CSV.read(filename)
  end

  def importable?(name)
    [
      "Drink",
      "Groceries",
      "Cats",
      "Haircuts",
      "Games and software",
      "Going out",
      "Necessities",
      "Gas",
      "Gifts",
      "Electronics",
      "Clothes",
      "MTS",
      "Home improvement",
      "Entertainment",
      "Water",
      "Necessities",
      "Clothes"
    ].include?(name)
  end

  def category(name)
    household.categories.find_by_name!(name)
  end

  def amount(value)
    value.gsub("$", "").gsub(",", "")
  end

end
