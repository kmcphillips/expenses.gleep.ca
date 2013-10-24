class Users::TokenController < ApplicationController
  layout 'devise'

  def token
    if session[:login_token_prevent_redirect]
      session[:login_token_prevent_redirect] = nil
    else
      @user = LoginToken.find_by_token(params[:token]).try(:user)

      sign_in @user if @user
      redirect_to new_entry_path
    end
  end

end