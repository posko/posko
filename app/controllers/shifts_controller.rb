class ShiftsController < ApplicationController
  def index
    @shifts = user.shifts
    render json: blueprint(@shifts)
  end

  def create
    @shift = user.shifts.new shift_params
    if shift.save
      render json: blueprint(shift)
    else
      render_record_invalid(shift)
    end
  end

  def show
    render json: blueprint(shift)
  end

  # rubocop:disable Metrics/AbcSize
  def finalize_shift
    @shift = Shift.find(params[:id])
    shift_attributes = ShiftCalculatorService.perform(shift: @shift).attributes
    shift.assign_attributes(shift_attributes.merge(shift_status: :ended))
    if shift.save
      render json: blueprint(shift)
    else
      render_record_invalid(shift)
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def shift
    @shift ||= source.find(params[:id])
  end

  def source
    if params[:user_id]
      user.shifts
    else
      Shift.all
    end
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
