FactoryGirl.define do
  factory :entry do
    description "Something"
    amount 12
    incurred_on "2013-09-07"

    after(:build) do |entry|
      user = FactoryGirl.create(:user)
      binding.pry
      entry.user = user
      entry.category = FactoryGirl.create(:category, household: user.household)
      entry.household = user.household
    end
  end
end
