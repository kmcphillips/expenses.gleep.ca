class CategoriesController < AuthenticatedController

  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  private

  def categories_params
    params.require(:category).permit()
  end

end
