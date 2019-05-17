require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    it 'assigns @users' do
      get :index
      expect(assigns(:users)).to eq([user])
      expect(json).to include_json(users: [])
    end
  end

  describe 'POST #create' do
    context 'with passing params' do
      let(:params) do
        {

          user: {
            email: 'valid@email.com',
            first_name: 'first',
            last_name: 'last',
            password: 'pass'
          }
        }
      end

      before { post(:create, params: params) }

      # Including current user
      it { expect(User.count).to eq(2) }
    end

    context 'with failing params' do
      let(:params) { { user: { email: nil, password: nil } } }

      before { post(:create, params: params) }

      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with passing params' do
      let(:params) { { id: user.id, user: { email: 'updated@email.com' } } }

      it { expect(assigns(:user).email).to eq('updated@email.com') }
      it { expect(json).to include_json(user: {}) }
    end

    context 'with failing params' do
      let(:params) { { id: user.id, user: { email: 'wrongformat' } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: user.id } }

    it { expect(assigns(:user)).to eq(user) }
    it { expect(json).to include_json(user: {}) }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:user1) { create(:user, account: user.account) }
      let(:params) { { id: user1.id } }

      it { expect(assigns(:user)).to be_destroyed }
      it { expect(json).to include_json(user: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
