class Api::V1::ShiftsController < Api::V1::ApiController
  before_action :authenticate_user

  def current
    @shift = current_user.current_shift
    if @shift
      render json: { shift: @shift }
    else
      render json: { error: "You don't have any ongoing shift yet" }
    end
  end

  def create
    if current_user.current_shift
      render json: { error: 'Close your current shift first' }
    else
      time = Time.current
      @shift = current_user.shifts.create(shift_params.merge(start_date: time))
      render json: { shift: @shift }
    end
  end

  def end_shift
    @shift = current_user.current_shift
    if @shift
      update_shift
      render json: { shift: @shift }
    else
      render json: { error: "You don't have any ongoing shift yet" }
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:starting_cash)
  end

  def update_shift
    service = ShiftCalculatorService.new shift: @shift
    @shift.update(
      paid_out: service.paid_out,
      paid_in: service.paid_in,
      payments: service.payments,
      cash: service.cash,
      end_date: Time.current,
      shift_status: :ended
    )
  end
end
