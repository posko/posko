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

  describe 'GET #edit' do
    it 'assigns @shift' do
      params = { id: shift.id }
      get :edit, params: params
      expect(assigns(:shift)).to eq(shift)
    end
  end

  describe 'PATCH #update' do
    context 'with successful attempt' do
      it 'updates shift' do
        params = { id: shift.id, shift: { starting_cash: 100 } }
        patch :update, params: params
        expect(assigns(:shift).starting_cash).to eq(100)
        expect(response).to redirect_to(user_shifts_path(user))
      end
    end

    context 'with failed attempt' do
      it "renders 'edit'" do
        params = { id: shift.id, shift: { starting_cash: nil } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'GET #show' do
    it 'updates shift' do
      params = { id: shift.id }
      patch :show, params: params
      expect(assigns(:shift)).to eq(shift)
    end
  end

  describe 'DELETE #destroy' do
    it 'updates shift' do
      params = { id: shift.id }
      delete :destroy, params: params
      expect(assigns(:shift)).to eq(shift)
    end
    it 'raises an exception' do
      expect do
        delete :destroy, params: { id: 'nothing' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
