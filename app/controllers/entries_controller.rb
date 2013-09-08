class EntriesController < AuthenticatedController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = current_household.entries.sorted.only_whole

    if params[:category_id]
      @entries = @entries.for_category(params[:category_id])
      @filter_title = Category.find(params[:category_id]).name

    elsif params[:type]
      case params[:type]
      when 'expense'
        @entries = @entries.expense
        @filter_title = "expenses"
      when 'income'
        @entries = @entries.income
        @filter_title = "income"
      when 'scheduled'
        @entries = @entries # TODO
        @filter_title = "TODO"
      end

    elsif params[:scope]
      case params[:scope]
      when 'this_month'
        @entries = @entries.this_month
        @filter_title = Date.today.to_s(:month)
      when 'last_month'
        @entries = @entries.last_month
        @filter_title = (Date.today - 1.month).to_s(:month)
      end
    end

  end

  def show
  end

  def new
    @entry = current_household.entries.build incurred_on: Date.today
  end

  def edit
  end

  def create
    @entry = current_household.entries.build(entry_params)
    @entry.user = current_user

    if @entry.save
      redirect_to new_entry_path, notice: 'Entry was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @entry.update(entry_params)
      redirect_to entries_path, notice: 'Entry was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry was successfully destroyed.'
  end

  private

  def set_entry
    @entry = current_household.entries.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:category_id, :description, :amount, :incurred_on, :incurred_until)
  end

end
