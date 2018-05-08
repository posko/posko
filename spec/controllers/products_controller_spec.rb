require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:account){ create(:account) }
  let(:user){ create(:user, account: account)}
  let(:product) { create(:product, account: account) }
  let(:valid_product_param) { { title: "Bag", price: "99.9", product_type: "regular", vendor: "Bag Company" } }
  before { sign_in }
  describe "GET #index" do
    it "assigns @products" do
      get :index
      expect(assigns(:products)).to eq([product])
    end

  end
  describe "GET #new" do
    it "assigns @product" do
      get :new
      expect(assigns(:product)).to be_a_new_record
    end
  end
  describe "POST #create" do
    context "successful attempt" do
      let(:params) {{ product: valid_product_param }}
      before { post(:create, params: params)}
      it "creates product" do
        expect(account.products.count).to eq(1)
      end
    end

    context "failed attempt" do
      before { product }
      it "renders 'new' template" do
        params = { product: { title: nil, price: "99.9"} }
        post(:create, params: params)
        expect(response).to render_template "new"
      end
    end
  end
  describe "GET #edit" do
    it "assigns @product" do
      params = {id: product.id}
      get :edit, params: params
      expect(assigns(:product)).to eq(product)
    end
  end
  describe "PATCH #update" do
    context "successful attempt" do
      it "updates product" do
        params = { id: product.id, product: { title: "High Quality Bag" }}
        patch :update, params: params
        expect(assigns(:product).title).to eq("High Quality Bag")
        expect(response).to redirect_to(products_path)
      end
    end
    context "failed attempt" do
      it "renders 'edit'" do
        params = { id: product.id, product: { title: nil }}
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end
  describe "GET #show" do
    it "updates product" do
      params = { id: product.id }
      patch :show, params: params
      expect(assigns(:product)).to eq(product)
    end
  end
  describe "DELETE #destroy" do
    it "updates product" do
      params = { id: product.id }
      delete :destroy, params: params
      expect(assigns(:product)).to eq(product)
      expect(assigns(:product).deleted_status?).to be_truthy
    end
    it "raises an exception" do
      expect{ delete :destroy, params: { id:"nothing" } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
