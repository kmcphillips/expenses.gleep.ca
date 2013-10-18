FactoryGirl.define do
  factory :login_token do
    association :user, factory: :user
    description "A device"
    after(:build) do |login_token|
      login_token.household = login_token.user.household
    end
  end
end
