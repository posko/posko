require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
  let(:user) { create(:user) }
  let(:shift) { create(:shift, user: user) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    before do
      shift
      get :index, params: { user_id: user.id }
    end

    it { expect(assigns(:shifts)).to eq([shift]) }
    it { expect(json).to include_json(shifts: []) }
  end

  describe 'POST #create' do
    before { post(:create, params: params) }

    context 'with passing params' do
      let(:params) { { user_id: user.id, shift: { starting_cash: 10 } } }

      it { expect(Shift.count).to eq(1) }
      it { expect(json).to include_json(shift: {}) }
    end

    context 'with failing params' do
      let(:params) { { user_id: user.id, shift: { starting_cash: nil } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: shift.id } }

    it { expect(response).to have_http_status(:success) }
    it { expect(json).to include_json(shift: {}) }
  end

  describe 'PATCH #finalize_shift' do
    let(:params) { { id: shift.id } }
    let(:resulting_shift) do
      {
        shift: {
          cash: '1800.0',
          paid_in: '700.0',
          paid_out: '100.0',
          payments: '1000.0',
          shift_status: 'ended'
        }
      }
    end

    before do
      create(:invoice, subtotal: 1000, shift: shift)
      create(:shift_activity, :pay_in, amount: 500, shift: shift)
      create(:shift_activity, :pay_in, amount: 200, shift: shift)
      create(:shift_activity, :pay_out, amount: 100, shift: shift)
      patch :finalize_shift, params: params
    end

    it { expect(json).to include_json(resulting_shift) }
  end
end
