# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorized_email do
    email "MyString"
    household_id 1
  end
end
