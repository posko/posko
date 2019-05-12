require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  let(:user) { create(:user) }
  let(:role) { create(:role, name: 'manager', account: user.account) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end

  describe 'GET #index' do
    before { role }

    it 'assigns @roles' do
      get :index
      expect(assigns(:roles)).to eq([role])
      expect(json).to include_json(roles: [])
    end
  end

  describe 'POST #create' do
    before { post(:create, params: params) }

    context 'with successful attempt' do
      let(:params) { { role: { name: 'supervisor' } } }

      it { expect(Role.count).to eq(1) }
    end

    context 'with failed attempt' do
      let(:params) { { role: { name: nil } } }

      before { role }

      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with passing params' do
      let(:params) { { id: role.id, role: { name: 'admin' } } }

      it { expect(assigns(:role).name).to eq('admin') }
      it { expect(json).to include_json(role: {}) }
    end


    context 'with failing params' do
      let(:params) { { id: role.id, role: { name: nil } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: role.id } }

    it { expect(assigns(:role)).to eq(role) }
    it { expect(json).to include_json(role: {}) }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: role.id } }

      it { expect(assigns(:role)).to be_destroyed }
      it { expect(json).to include_json(role: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
