FactoryGirl.define do
  factory :authorized_email do
    email "test@example.com"
    association :household, factory: :household
  end
end
