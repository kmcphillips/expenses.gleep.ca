FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{ n }@example.com" }
    name "Spendy McSpend-Money"
    password "asdfasdf"
    password_confirmation "asdfasdf"
    household
  end
end
