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
    let(:user) { create(:user, email: 'admin@firstcompany.com', password: 'password', account: account) }
    context 'correct credentials' do
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
        expect(assigns(:sign_in_form).account.persisted?).to be_truthy
        expect(assigns(:sign_in_form).user.persisted?).to be_truthy
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context 'incorrect credentials' do
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
        expect(assigns(:sign_in_form).account.persisted?).to be_truthy
        expect(assigns(:sign_in_form).user.persisted?).to be_truthy
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'signs out user' do
      get :destroy
      expect(response).to redirect_to(sign_in_path)
    end
    it 'signs out user' do
      delete :destroy
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
