class AuthenticatedController < ApplicationController
  before_action :authenticate_user!, :reset_login_token_session, :check_read_only

  helper_method :current_household

  protected

  def current_household
    current_user.try(:household)
  end

  def reset_login_token_session
    session[:login_token_prevent_redirect] = nil
  end

  def read_only?
    !!Rails.application.secrets[:read_only]
  end

  def check_read_only
    if read_only?
      sign_out current_user
      flash[:notice] = "You cannot login at this time. Site temporarily in read-only mode."
      redirect_to new_user_session_path
    end

    true
  end

end
