class AuthenticatedController < ApplicationController
  before_action :authenticate_user!

  helper_method :current_household

  def current_household
    current_user.try(:household)
  end

end
