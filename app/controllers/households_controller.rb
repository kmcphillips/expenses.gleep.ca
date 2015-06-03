class HouseholdsController < AuthenticatedController
  before_action :set_objects

  def show
  end

  def edit
  end

  def update
    if @household.update(households_params)
      redirect_to household_path(@household), notice: 'Household was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def set_objects
    @household = Household.find(params[:id])
  end

  def households_params
    params.require(:household).permit(:name, :started_on, :active)
  end

end
