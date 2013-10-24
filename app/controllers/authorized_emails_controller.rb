class AuthorizedEmailsController < AuthenticatedController

  def index
    @authorized_emails = current_household.authorized_emails
  end

  def create
    @authorized_email = current_household.authorized_emails.build(authorized_email_params)

    if @authorized_email.save
      redirect_to authorized_emails_path, notice: 'Authorized email was successfully created.'
    else
      @authorized_emails = current_household.authorized_emails
      render action: 'index'
    end
  end

  def destroy
    @authorized_email = current_household.authorized_emails.find(params[:id])
    @authorized_email.destroy

    redirect_to authorized_emails_path, notice: 'Authorized email was successfully destroyed.'
  end

  private

  def authorized_email_params
    params.require(:authorized_email).permit(:email)
  end

end
