FactoryGirl.define do
  factory :authorized_email do
    sequence(:email){|n| "test#{ n }@example.com" }
    association :household, factory: :household
  end
end
