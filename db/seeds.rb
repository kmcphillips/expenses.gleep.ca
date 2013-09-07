class DatabaseSeeds

  def initialize
    puts "-- Seeding database"

    household
    puts "   - Household created"

    categories
    puts "   - Categories created"
  end

  def categories
    add_category "Mortgage", essential: true
    add_category "Property Tax", essential: true
    add_category "Insurance", essential: true
    add_category "Hydro", essential: true
    add_category "Water", essential: true
    add_category "MTS", essential: true
    add_category "Car Insurance", essential: true
    add_category "Gas"
    add_category "Alarm", essential: true
    add_category "Subscriptions", description: "Rdio, Netflix, etc."
    add_category "Cats", essential: true
    add_category "Studio"
    add_category "Haircuts", essential: true
    add_category "Necessities", essential: true, description: "Medical, non-food groceries, etc."
    add_category "Entertainment"
    add_category "Groceries", essential: true
    add_category "Drink"
    add_category "Going Out"
    add_category "Clothes"
    add_category "Home Improvement", essential: true
    add_category "Gifts"
    add_category "Travel"
    add_category "Electronics"
    add_category "Games and Software"

    add_category "Shopify", income: true
    add_category "Performing", income: true
    add_category "Other", income: true
  end

  def household
    @household ||= Household.create!(name: "Grace and Kevin")
  end

  private

  def add_category(name, attributes={})
    Category.create!({name: name, household: household, active: true, essential: false, income: false}.merge(attributes))
  end

end

DatabaseSeeds.new
