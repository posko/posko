require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:product) { create(:product, account: user.account) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }
  describe 'GET /api/v1/products' do
    it "returns list of products" do
      create(:product, account: account)
      get "/api/v1/products", headers: headers
      expect(account.products.count).to eq(1)
      expect(json).to include_json(products: [])
    end
  end
  
  describe 'GET /api/v1/products/:id' do
    context "with existing product" do
      it "returns the product" do
        get "/api/v1/products/#{product.id}", headers: headers
        expect(json).to include_json(product: {})
        expect(response).to have_http_status(:ok)
      end
    end
    context "with a non-existent product" do
      it "returns the 404" do
        get "/api/v1/products/0", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
