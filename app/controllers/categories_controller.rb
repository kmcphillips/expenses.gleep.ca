class CategoriesController < AuthenticatedController

  def index
    @category = Category.find(params[:id])
  end

  private

  def categories_params
    params.require(:category).permit()
  end

end
