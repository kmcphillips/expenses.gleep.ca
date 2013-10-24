class AuthenticatedController < ApplicationController
  before_action :authenticate_user!, :reset_login_token_session

  helper_method :current_household

  def current_household
    current_user.try(:household)
  end

  def reset_login_token_session
    session[:login_token_prevent_redirect] = nil
  end

end
