RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end

def login_as_user
  user = FactoryGirl.create(:user)
  sign_in user
  user
end
