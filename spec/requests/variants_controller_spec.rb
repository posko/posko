require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:product) { create(:product, account: account) }
  let(:variant) { create(:variant, product: product) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }
  before { variant }
  describe 'GET /api/v1/products/:product_id/variants' do
    it "returns list of variants" do
      get "/api/v1/products/#{product.id}/variants", headers: headers
      expect(json["variants"].count).to eq(1)
      expect(json).to include_json(variants: [])
    end
  end

  describe 'GET /api/v1/variants/:id' do
    context "with existing variant" do
      it "returns the variant" do
        get "/api/v1/variants/#{variant.id}", headers: headers
        expect(json).to include_json(variant: {})
        expect(response).to have_http_status(:ok)
      end
    end
    context "with a non-existent variant" do
      it "returns the 404" do
        get "/api/v1/variants/0", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
