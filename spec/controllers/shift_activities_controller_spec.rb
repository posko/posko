require 'rails_helper'

RSpec.describe ShiftActivitiesController, type: :controller do
  let(:user) { create(:user) }
  let(:shift_activity) { create(:shift_activity) }
  let(:shift) { shift_activity.shift }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end

  describe 'GET #index' do
    it 'assigns @shift_activities' do
      get :index, params: { shift_id: shift.id }
      expect(assigns(:shift_activities)).to eq([shift_activity])
    end
  end

  describe 'GET #new' do
    it 'assigns @shift_activity' do
      get :new, params: { shift_id: shift.id }
      expect(assigns(:shift_activity)).to be_a_new_record
    end
  end

  describe 'POST #create' do
    context 'with successful attempt' do
      before { shift_activity }

      it 'creates shift_activity' do
        params = { shift_id: shift.id, shift_activity: { amount: 20 } }
        expect do
          post(:create, params: params)
        end.to change(ShiftActivity, :count).by(1)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns @shift_activity' do
      params = { id: shift_activity.id }
      get :edit, params: params
      expect(assigns(:shift_activity)).to eq(shift_activity)
    end
  end

  describe 'PATCH #update' do
    context 'with successful attempt' do
      it 'updates shift_activity' do
        params = { id: shift_activity.id, shift_activity: { amount: 10 } }
        patch :update, params: params
        expect(assigns(:shift_activity).amount).to eq(10)
        expect(response).to redirect_to(shift_shift_activities_path(shift))
      end
    end

    context 'with failed attempt' do
      it "renders 'edit'" do
        params = { id: shift_activity.id, shift_activity: { amount: nil } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'GET #show' do
    it 'updates shift_activity' do
      params = { id: shift_activity.id }
      patch :show, params: params
      expect(assigns(:shift_activity)).to eq(shift_activity)
    end
  end

  describe 'DELETE #destroy' do
    it 'updates shift_activity' do
      params = { id: shift_activity.id }
      delete :destroy, params: params
      expect(assigns(:shift_activity)).to eq(shift_activity)
    end
    it 'raises an exception' do
      expect do
        delete :destroy, params: { id: 'nothing' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
