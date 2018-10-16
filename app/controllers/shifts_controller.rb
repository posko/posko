class ShiftsController < ApplicationController
  def index
    @shifts = user.shifts
  end

  def new
    @shift = user.shifts.new
  end

  def create
    @shift = user.shifts.new shift_params
    if @shift.save
      redirect_to user_shifts_path user
    else
      render 'new'
    end
  end

  def show
    @shift = Shift.find(params[:id])
  end

  def end_shift
    @shift = Shift.find(params[:id])
  end

  def finalize_shift
    @shift = Shift.find(params[:id])
    shift_attributes = ShiftCalculatorService.perform(shift: @shift).attributes
    @shift.assign_attributes(shift_attributes)
    @shift.shift_status = 'ended'
    if @shift.save
      redirect_to @shift
    else
      render :end_shift
    end
  end

  private

  def shift
    @shift ||= user.shifts.find_by(params[:id])
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def shift_params
    params.require(:shift).permit(
      :start_date,
      :end_date,
      :user_id,
      :starting_cash,
      :payments,
      :paid_in,
      :paid_out,
      :cash
    )
  end
end
