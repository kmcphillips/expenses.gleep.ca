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

  def update
    @category = current_household.categories.find(params[:id])

    if @category.update(categories_params)
      redirect_to categories_path, notice: "Category updated successfully."
    else
      render :edit
    end
  end

  private

  def categories_params
    params.require(:category).permit(:name, :description, :income, :category_type, :active)
  end

end
