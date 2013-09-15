class HouseholdsController < AuthenticatedController
  before_action :set_objects

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_objects
    @household = current_household
  end

  def households_params
    params.require(:household).permit(:name, :started_on)
  end

end
