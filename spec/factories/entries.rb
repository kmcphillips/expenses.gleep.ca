# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    category_id 1
    household_id 1
    user_id 1
    description "MyText"
    amount 1.5
    incurred_on "2013-09-07"
  end
end
