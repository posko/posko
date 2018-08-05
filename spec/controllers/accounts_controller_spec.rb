require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_user_param) { { email: "valid@email.com", first_name: "first", last_name: "last", password: "pass" } }
  before { allow(controller).to receive(:current_user).and_return(user) }
  describe "GET #new" do
    it "assigns @registration_form" do
      get :new
      expect(assigns(:registration_form).persisted?).to be_falsey
    end
  end
  describe "POST #create" do
    context "valid" do
      it "signs up an account" do
        get :create,
            params: {
              registration_form: {
                account_name: "new_company",
                company: "New Company Inc.",
                first_name: "Juan",
                last_name: "Dela Cruz",
                email: "juan@new_company.com",
                password: "thebestjuan"
              }
            }
        expect(assigns(:registration_form).account.persisted?).to be_truthy
        expect(assigns(:registration_form).user.persisted?).to be_truthy
      end
    end
    context "invalid" do
      it "renders 'new' " do
        get :create, params: { registration_form: { account_name: "Incomplete Company" } }

        expect(response).to render_template :new
      end
    end
  end
end
