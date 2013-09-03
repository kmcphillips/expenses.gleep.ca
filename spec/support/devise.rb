RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end

def login
  user = FactoryGirl.create(:user)
  sign_in user
  user
end
