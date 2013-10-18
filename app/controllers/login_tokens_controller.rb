class LoginTokensController < AuthenticatedController

  def index
    @login_tokens = current_household.login_tokens
  end

  def create
    @login_token = current_household.login_tokens.build(login_token_params)

    if @login_token.save
      redirect_to login_tokens_path, notice: 'Login token was successfully created.'
    else
      @login_tokens = current_household.login_tokens
      render action: 'index'
    end
  end

  def destroy
    @login_token = current_household.login_tokens.find(params[:id])
    @login_token.destroy

    redirect_to login_tokens_path, notice: 'Login token was successfully destroyed.'
  end

  private

  def login_token_params
    params.require(:login_token).permit(:description, :user_id)
  end

end
