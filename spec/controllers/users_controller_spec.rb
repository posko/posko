require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_user_param) do
    {
      email: 'valid@email.com',
      first_name: 'first',
      last_name: 'last',
      password: 'pass'
    }
  end

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    it 'assigns @users' do
      get :index
      expect(assigns(:users)).to eq([user])
    end
  end

  describe 'POST #create' do
    context 'with successful attempt' do
      before { user }

      it 'creates user' do
        params = { user: valid_user_param }
        expect { post(:create, params: params) }.to change(User, :count).by(1)
      end
    end

    context 'with failed attempt' do
      before { user }

      it "renders 'new' template" do
        params = { user: { email: nil, password: nil } }
        post(:create, params: params)
        expect(json).to include_json(errors: {})
      end
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with successful attempt' do
      let(:params) { { id: user.id, user: { email: 'updated@email.com' } } }

      it { expect(assigns(:user).email).to eq('updated@email.com') }
      it { expect(json).to include_json(user: {}) }
    end

    context 'with failed attempt' do
      let(:params) { { id: user.id, user: { email: 'wrongformat' } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    it 'updates user' do
      params = { id: user.id }
      patch :show, params: params
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: user.id } }

      it { expect(assigns(:user)).to be_destroyed }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
