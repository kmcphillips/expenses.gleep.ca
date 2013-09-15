FactoryGirl.define do
  factory :entry_schedule do
    name "Mortgage"
    association(:category, factory: :category)
    association(:household, factory: :household)
    amount 900
    starts_on "2012-01-01"
    frequency "monthly"
  end
end
