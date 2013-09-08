class AuthorizedEmailsController < ApplicationController

  def index
    @authorized_emails = current_household
  end

  def create
    @authorized_email = AuthorizedEmail.new(authorized_email_params)

    if @authorized_email.save
      redirect_to authorized_emails_path, notice: 'Authorized email was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @authorized_email = AuthorizedEmail.find(params[:id])
    @authorized_email.destroy

    redirect_to authorized_emails_path, notice: 'Authorized email was successfully destroyed.'
  end

  private

  def authorized_email_params
    params.require(:authorized_email).permit(:email)
  end

end
