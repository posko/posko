require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }
  let(:valid_customer_param) { { email: "valid@email.com", first_name: "first", last_name: "last", password: "pass" } }
  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end
  describe "GET #index" do
    it "assigns @customers" do
      get :index
      expect(assigns(:customers)).to eq([customer])
    end
  end
  describe "GET #new" do
    it "assigns @customer" do
      get :new
      expect(assigns(:customer)).to be_a_new_record
    end
  end
  describe "POST #create" do
    context "successful attempt" do
      before { customer }
      it "creates customer" do
        params = { customer: valid_customer_param }
        expect{post(:create, params: params)}.to change(Customer, :count).by(1)
      end
    end

    context "failed attempt" do
      before { customer }
      it "renders 'new' template" do
        params = { customer: { email: nil, password: nil} }
        post(:create, params: params)
        expect(response).to render_template "new"
      end
    end
  end
  describe "GET #edit" do
    it "assigns @customer" do
      params = {id: customer.id}
      get :edit, params: params
      expect(assigns(:customer)).to eq(customer)
    end
  end
  describe "PATCH #update" do
    context "successful attempt" do
      it "updates customer" do
        params = { id: customer.id, customer: { email: "updated@email.com" }}
        patch :update, params: params
        expect(assigns(:customer).email).to eq("updated@email.com")
        expect(response).to redirect_to(customers_path)
      end
    end
    context "failed attempt" do
      it "renders 'edit'" do
        params = { id: customer.id, customer: { first_name: "" } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end
  describe "GET #show" do
    it "updates customer" do
      params = { id: customer.id }
      patch :show, params: params
      expect(assigns(:customer)).to eq(customer)
    end
  end
  describe "DELETE #destroy" do
    it "updates customer" do
      params = { id: customer.id }
      delete :destroy, params: params
      expect(assigns(:customer)).to eq(customer)
    end
    it "raises an exception" do
      expect{ delete :destroy, params: { id:"nothing" } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
