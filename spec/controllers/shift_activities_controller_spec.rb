require 'rails_helper'

RSpec.describe ShiftActivitiesController, type: :controller do
  let(:user) { create(:user) }
  let(:shift) { create(:shift) }
  let(:shift_activity) { create(:shift_activity, shift: shift) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    before do
      shift_activity
      get :index, params: { shift_id: shift.id }
    end

    it { expect(assigns(:shift_activities)).to eq([shift_activity]) }
    it { expect(json).to include_json(shift_activities: []) }
  end

  describe 'POST #create' do
    before { post(:create, params: params) }

    context 'with passing params' do
      let(:params) { { shift_id: shift.id, shift_activity: { amount: 20 } } }

      it { expect(ShiftActivity.count).to eq(1) }
      it { expect(json).to include_json(shift_activity: {}) }
    end

    context 'with failing params' do
      let(:params) { { shift_id: shift.id, shift_activity: { amount: nil } } }

      it { expect(json).to include_json(errors: {}) }
    end
  end

  # describe 'POST #create' do
  #   context 'with passing params' do
  #     before { shift_activity }
  #
  #     it 'creates shift_activity' do
  #       params = { shift_id: shift.id, shift_activity: { amount: 20 } }
  #       expect do
  #         post(:create, params: params)
  #       end.to change(ShiftActivity, :count).by(1)
  #     end
  #   end
  # end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with passing params' do
      let(:params) { { id: shift_activity.id, shift_activity: { amount: 10 } } }

      it { expect(assigns(:shift_activity).amount).to eq(10) }
      it { expect(json).to include_json(shift_activity: {}) }
    end

    context 'with failing params' do
      let(:params) do
        { id: shift_activity.id, shift_activity: { amount: nil } }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end
  #
  # describe 'PATCH #update' do
  #   context 'with passing params' do
  #     it 'updates shift_activity' do
  #       params = { id: shift_activity.id, shift_activity: { amount: 10 } }
  #       patch :update, params: params
  #       expect(assigns(:shift_activity).amount).to eq(10)
  #       expect(response).to redirect_to(shift_shift_activities_path(shift))
  #     end
  #   end
  #
  #   context 'with failing params' do
  #     it "renders 'edit'" do
  #       params = { id: shift_activity.id, shift_activity: { amount: nil } }
  #       patch :update, params: params
  #       expect(response).to render_template('edit')
  #     end
  #   end
  # end

  describe 'GET #show' do
    before { get :show, params: { id: shift_activity.id } }

    it { expect(assigns(:shift_activity)).to eq(shift_activity) }
    it { expect(json).to include_json(shift_activity: {}) }
  end
  #
  # describe 'GET #show' do
  #   it 'updates shift_activity' do
  #     params = { id: shift_activity.id }
  #     patch :show, params: params
  #     expect(assigns(:shift_activity)).to eq(shift_activity)
  #   end
  # end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: shift_activity.id } }

      it { expect(assigns(:shift_activity)).to be_destroyed }
      it { expect(json).to include_json(shift_activity: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end

  # describe 'DELETE #destroy' do
  #   it 'updates shift_activity' do
  #     params = { id: shift_activity.id }
  #     delete :destroy, params: params
  #     expect(assigns(:shift_activity)).to eq(shift_activity)
  #   end
  #   it 'raises an exception' do
  #     expect do
  #       delete :destroy, params: { id: 'nothing' }
  #     end.to raise_error(ActiveRecord::RecordNotFound)
  #   end
  # end
end
