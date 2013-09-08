FactoryGirl.define do
  factory :category do
    name "a purchase"
    income false
    essential false
    association :household, factory: :household
  end
end
