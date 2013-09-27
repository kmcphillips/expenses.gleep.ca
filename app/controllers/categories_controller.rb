class CategoriesController < AuthenticatedController

  def index
    @categories = Category.sorted
  end

  def edit
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new categories_params
    @category.household = current_household

    if @category.save
      redirect_to categories_path, notice: "Category created successfully."
    else
      render :new
    end
  end

  private

  def categories_params
    params.require(:category).permit(:name, :description, :income, :category_type, :active)
  end

end
