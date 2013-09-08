# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry_schedule do
    name "MyString"
    category_id 1
    household_id 1
    amount 1.5
    starts_on "2013-09-08"
    frequency "MyString"
  end
end
