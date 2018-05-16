require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }
  let(:account) { user.account }
  let(:order) { create(:order, account: account ) }
  let(:valid_order_param) { { customer_id: customer.id, order_number: 1 } }
  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(account)
  end
  describe "GET #index" do
    it "assigns @orders" do
      get :index
      expect(assigns(:orders)).to eq(user.account.orders)
    end
  end
  describe "GET #new" do
    it "assigns @order" do
      get :new
      expect(assigns(:order)).to be_a_new_record
    end
  end
  describe "POST #create" do
    context "successful attempt" do
      before { order }
      it "creates order" do
        params = { order: valid_order_param }
        expect {post(:create, params: params)}.to change(Order, :count).by(1)
      end
    end

    context "failed attempt" do
      before { order }
      it "renders 'new' template" do
        params = { order: {customer_id: nil} }
        post(:create, params: params)
        expect(response).to render_template "new"
      end
    end
  end
  describe "GET #edit" do
    it "assigns @order" do
      params = {id: order.id}
      get :edit, params: params
      expect(assigns(:order)).to eq(order)
    end
  end
  describe "PATCH #update" do
    context "successful attempt" do
      it "updates order" do
        params = { id: order.id, order: { order_number: 2 }}
        patch :update, params: params
        expect(assigns(:order).order_number).to eq(2)
        expect(response).to redirect_to(orders_path)
      end
    end
    context "failed attempt" do
      it "renders 'edit'" do
        params = { id: order.id, order: { order_number: nil } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end
  describe "GET #show" do
    it "updates order" do
      params = { id: order.id }
      patch :show, params: params
      expect(assigns(:order)).to eq(order)
    end
  end
  describe "DELETE #destroy" do
    it "updates order" do
      params = { id: order.id }
      delete :destroy, params: params
      expect(assigns(:order)).to eq(order)
    end
    it "raises an exception" do
      expect { delete :destroy, params: { id: "nothing" } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
