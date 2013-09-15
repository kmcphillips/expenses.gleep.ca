FactoryGirl.define do
  factory :category do
    name "a purchase"
    income false
    category_type "non-essential"
    association :household, factory: :household
  end
end
