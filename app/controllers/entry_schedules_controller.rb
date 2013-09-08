class EntrySchedulesController < AuthenticatedController
  before_action :set_entry_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @entry_schedules = current_household.entry_schedules
  end

  def show
  end

  def new
    @entry_schedule = current_household.entry_schedules.build
  end

  def edit
  end

  def create
    @entry_schedule = current_household.entry_schedules.build(entry_schedule_params)

    if @entry_schedule.save
      redirect_to entry_schedules_path, notice: 'Entry schedule was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @entry_schedule.update(entry_schedule_params)
      redirect_to entry_schedules_path, notice: 'Entry schedule was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @entry_schedule.destroy
    redirect_to entry_schedules_path, notice: 'Entry schedule was successfully destroyed.'
  end

  private

  def set_entry_schedule
    @entry_schedule = EntrySchedule.find(params[:id])
  end

  def entry_schedule_params
    params.require(:entry_schedule).permit(:name, :category_id, :amount, :starts_on, :frequency)
  end

end
