FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{ n }@example.com" }
  end
end
