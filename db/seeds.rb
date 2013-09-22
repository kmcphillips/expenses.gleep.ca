class DatabaseSeeds

  def initialize
    puts "-- Seeding database"

    household
    puts "   - Household created"

    categories
    puts "   - Categories created"
  end

  def categories
    add_category "Mortgage", category_type: "essential"
    add_category "Property Tax", category_type: "essential"
    add_category "Insurance", category_type: "essential"
    add_category "Hydro", category_type: "essential"
    add_category "Water", category_type: "essential"
    add_category "MTS", category_type: "essential"
    add_category "Car Insurance", category_type: "essential"
    add_category "Gas"
    add_category "Alarm", category_type: "essential"
    add_category "Subscriptions", description: "Rdio, Netflix, etc."
    add_category "Cats", category_type: "essential"
    add_category "Studio"
    add_category "Haircuts", category_type: "essential"
    add_category "Necessities", category_type: "essential", description: "Medical, non-food groceries, etc."
    add_category "Entertainment"
    add_category "Groceries", category_type: "essential"
    add_category "Drink"
    add_category "Going Out"
    add_category "Clothes"
    add_category "Home Improvement", category_type: "essential"
    add_category "Gifts"
    add_category "Travel"
    add_category "Electronics"
    add_category "Games and Software"

    add_category "Shopify", income: true
    add_category "Performing", income: true
    add_category "Other", income: true

    add_category "Travel (Savings)", category_type: "savings"
    add_category "House (Savings)", category_type: "savings"
    add_category "Career (Savings)", category_type: "savings"
  end

  def household
    @household ||= Household.create!(name: "Grace and Kevin", started_on: "2013-06-01")
  end

  private

  def add_category(name, attributes={})
    Category.create!({name: name, household: household, active: true, category_type: 'non-essential', income: false}.merge(attributes))
  end

end

DatabaseSeeds.new

if ENV["PRIVATE_SEED"] && File.exists?(ENV["PRIVATE_SEED"])
  puts "-- Private seed file loaded"
  require ENV["PRIVATE_SEED"]
end

