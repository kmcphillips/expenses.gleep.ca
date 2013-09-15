class ImportFromCsv
  attr_reader :rows, :household

  def initialize(filename, household)
    @rows = parse(filename)
    @household = household
    @category_names = Set.new
  end

  def run
    rows.each_with_index do |row, index|
      if index != 0
        date, category_name, description, expense_amount, income_amount, _ = row.to_a
        
        @category_names.add category_name

        entry = household.entries.build
      end
    end

    puts @category_names.to_a
  end

  private

  def parse(filename)
    CSV.read(filename)
  end

end
