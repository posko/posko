require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
  let(:user) { create(:user) }
  let(:shift) { create(:shift, user: user) }

  before do
    shift
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end

  describe 'GET #index' do
    it 'assigns @shifts' do
      get :index, params: { user_id: user.id }
      expect(assigns(:shifts)).to eq([shift])
    end
  end

  describe 'GET #new' do
    it 'assigns @shift' do
      get :new, params: { user_id: user.id }
      expect(assigns(:shift)).to be_a_new_record
    end
  end

  describe 'POST #create' do
    context 'with successful attempt' do
      before { shift }

      it 'creates shift' do
        params = { user_id: user.id, shift: { starting_cash: 10 } }
        expect do
          post(:create, params: params)
        end.to change(Shift, :count).by(1)
        expect(Shift.last.starting_cash).to eq(10)
      end
    end

    # context "with failed attempt" do
    #   before { shift }
    #   it "renders 'new' template" do
    #     params = { shift: { id: nil } }
    #     post(:create, params: params)
    #     expect(response).to render_template "new"
    #   end
    # end
  end

  describe 'GET #show' do
    it 'updates shift' do
      params = { id: shift.id }
      get :show, params: params
      expect(assigns(:shift)).to eq(shift)
    end
  end

  describe 'GET #end_shift' do
    it 'updates shift' do
      params = { id: shift.id }
      get :end_shift, params: params
      expect(assigns(:shift)).to eq(shift)
    end
  end

  describe 'PATCH #finalize_shift' do
    before do
      create(:invoice, subtotal: 1000, shift: shift)
      create(:shift_activity, :pay_in, amount: 500, shift: shift)
      create(:shift_activity, :pay_in, amount: 200, shift: shift)
      create(:shift_activity, :pay_out, amount: 100, shift: shift)
    end

    it 'updates shift' do
      params = { id: shift.id }
      patch :finalize_shift, params: params
      expect(response).to redirect_to(shift)
      expect(assigns(:shift)).to eq(shift)
      expect(assigns(:shift)).to be_ended
      expect(assigns(:shift).cash).to eq 1800
      expect(assigns(:shift).paid_in).to eq 700
      expect(assigns(:shift).paid_out).to eq 100
      expect(assigns(:shift).payments).to eq 1000
    end
  end
end
