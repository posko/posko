require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  # def new
  #   @sign_in = SignIn.new
  # end
  # def create
  #   @sign_in = SignIn.new sign_in_params
  #   if @sign_in.process
  #     session[:user_id] = @sign_in.user.id
  #     redirect_to dashboard_path
  #   else
  #     render "new"
  #   end
  # end
  # def destroy
  #   session[:user_id] = nil
  #   redirect_to sign_in_path
  # end
  describe "GET #new" do
    it "assigns @sign_in" do
      get :new
      expect(assigns(:sign_in).class).to eq(SignIn)
    end
  end
  describe "GET #create" do
    let(:account) { create(:account, account_name: "firstcompany") }
    let(:user) { create(:user, email: "admin@firstcompany.com", password: "password", account: account)}
    context "correct credentials" do
      before do
        # create user
        user
        post :create, params: {
          sign_in: {
            account_name: "firstcompany",
            email: "admin@firstcompany.com",
            password: "password"
          }
        }
      end
      it "redirects to dashboard" do
        expect(assigns(:sign_in).account.persisted?).to be_truthy
        expect(assigns(:sign_in).user.persisted?).to be_truthy
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "incorrect credentials" do
      before do
        # create user
        user
        post :create, params: {
          sign_in: {
            account_name: "firstcompany",
            email: "admin@firstcompany.com",
            password: "wrongpassword"
          }
        }
      end
      it "assigns @sign_in" do
        expect(assigns(:sign_in).account.persisted?).to be_truthy
        expect(assigns(:sign_in).user.persisted?).to be_truthy
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE #destroy" do
    it "signs out user" do
      get :destroy
      expect(response).to redirect_to(sign_in_path)
    end
    it "signs out user" do
      delete :destroy
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
