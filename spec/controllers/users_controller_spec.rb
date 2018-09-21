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

    it 'returns a json object' do
      get :index, format: :json,
                  params: {
                    "columns[0][data]": 'name',
                    "columns[0][search][regex]": false
                  }
      expect(response.body).to include_json("recordsTotal": 1)
    end
  end
  describe 'GET #new' do
    it 'assigns @user' do
      get :new
      expect(assigns(:user)).to be_a_new_record
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
        expect(response).to render_template 'new'
      end
    end
  end
  describe 'GET #edit' do
    it 'assigns @user' do
      params = { id: user.id }
      get :edit, params: params
      expect(assigns(:user)).to eq(user)
    end
  end
  describe 'PATCH #update' do
    context 'with successful attempt' do
      it 'updates user' do
        params = { id: user.id, user: { email: 'updated@email.com' } }
        patch :update, params: params
        expect(assigns(:user).email).to eq('updated@email.com')
        expect(response).to redirect_to(users_path)
      end
    end
    context 'with failed attempt' do
      it "renders 'edit'" do
        params = { id: user.id, user: { email: 'wrongformat' } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
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
    it 'updates user' do
      params = { id: user.id }
      delete :destroy, params: params
      expect(assigns(:user)).to eq(user)
    end
    it 'raises an exception' do
      expect do
        delete :destroy, params: { id: 'nothing' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
