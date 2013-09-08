class EntriesController < AuthenticatedController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = current_household.entries
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
      redirect_to @entry, notice: 'Entry was successfully updated.'
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
    params.require(:entry).permit(:category_id, :description, :amount, :incurred_on)
  end
end
