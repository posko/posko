require 'rails_helper'

RSpec.describe Api::V1::OrderLinesController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:customer) { create(:customer, account: account) }
  let(:order) { create(:order, account: user.account, user: user) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }

  let(:order_line) { create(:order_line, price: 100, title: "Large", order: order) }
  describe 'GET /api/v1/orders/:order_id/order_lines' do
    it "returns list of orders" do
      order_line
      get "/api/v1/orders/#{order.id}/order_lines", headers: headers
      expect(order.order_lines.count).to eq(1)
      expect(json).to include_json(order_lines: [])
    end
  end

  describe 'POST /api/v1/order/:order_id/order_lines' do
    let(:variant) { create(:variant, product: product, price: 200) }
    let(:product) { create(:product, account: account) }
    let(:params) do
      {
        order_line: {
          title: variant.title,
          price: price,
          variant_id: variant.id,
          product_id: product.id
        }
      }
    end
    before { post "/api/v1/orders/#{order.id}/order_lines", params: params, headers: headers }
    context "with correct params" do
      let(:price) { 200 }
      it "creates a order" do
        expect(order.order_lines.count).to eq(1)
        expect(response).to have_http_status(:ok)
        expect(json).to include_json(order_line: { price: "200.0" }, order: { total_line_items_price: "200.0" })
      end
    end

    context "with incorrect params" do
      let(:price) { nil }
      it "rejects request" do
        expect(order.order_lines.count).to eq(0)
        expect(json).to include_json(messages: ["Price can't be blank"])
      end
    end
  end

  describe 'GET /api/v1/order_lines/:id' do
    context "with existing order" do
      it "returns the order" do
        get "/api/v1/order_lines/#{order_line.id}", headers: headers
        expect(json).to include_json(order_line: {})
        expect(response).to have_http_status(:ok)
      end
    end
    context "with a non-existent order" do
      it "returns the 404" do
        get "/api/v1/order_lines/0", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
