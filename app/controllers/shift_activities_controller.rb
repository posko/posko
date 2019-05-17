class ShiftActivitiesController < ApplicationController
  def index
    @shift_activities = shift.shift_activities
    render json: blueprint(@shift_activities)
  end

  def create
    @shift_activity = shift.shift_activities.new shift_activity_params
    if shift_activity.save
      render json: blueprint(shift_activity)
    else
      render_record_invalid(shift_activity)
    end
  end

  def update
    if shift_activity.update(shift_activity_params)
      render json: blueprint(shift_activity)
    else
      render_record_invalid(shift_activity)
    end
  end

  def show
    render json: blueprint(shift_activity)
  end

  def destroy
    shift_activity.destroy
    render json: blueprint(shift_activity)
  end

  private

  def shift
    @shift ||= Shift.find(params[:shift_id])
  end

  def shift_activity
    @shift_activity ||= ShiftActivity.find(params[:id])
  end

  def shift_activity_params
    params.require(:shift_activity).permit(:date, :amount, :remarks, :shift_id,
      :shift_activity_type)
  end
end
