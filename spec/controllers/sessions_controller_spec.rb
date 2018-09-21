require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'assigns @sign_in_form' do
      get :new
      expect(assigns(:sign_in_form)).to be_instance_of(SignInForm)
    end
  end
  describe 'GET #create' do
    let(:account) { create(:account, account_name: 'firstcompany') }
    let(:user) do
      create(:user, email: 'admin@firstcompany.com', password: 'password',
                    account: account)
    end

    context 'with correct credentials' do
      before do
        # create user
        user
        post :create, params: {
          sign_in_form: {
            account_name: 'firstcompany',
            email: 'admin@firstcompany.com',
            password: 'password'
          }
        }
      end
      it 'redirects to dashboard' do
        expect(assigns(:sign_in_form).account).to be_persisted
        expect(assigns(:sign_in_form).user).to be_persisted
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context 'with incorrect credentials' do
      before do
        # create user
        user
        post :create, params: {
          sign_in_form: {
            account_name: 'firstcompany',
            email: 'admin@firstcompany.com',
            password: 'wrongpassword'
          }
        }
      end
      it 'assigns @sign_in_form' do
        expect(assigns(:sign_in_form).account).to be_persisted
        expect(assigns(:sign_in_form).user).to be_persisted
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'signs out user using get' do
      get :destroy
      expect(response).to redirect_to(sign_in_path)
    end
    it 'signs out user using delete' do
      delete :destroy
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
