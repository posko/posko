require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:customer) { create(:customer, account: account) }
  let(:order) { create(:order, account: user.account, user: user) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }
  describe 'GET /api/v1/orders' do
    it "returns list of orders" do
      order
      get "/api/v1/orders", headers: headers
      expect(account.orders.count).to eq(1)
      expect(json).to include_json(orders: [])
    end
  end

  describe 'POST /api/v1/orders' do
    context "with correct params" do
      it "creates a order" do
        params = {
          order: {
            customer_id: customer.id,
            order_number: 25
          }
        }
        post "/api/v1/orders", params: params, headers: headers
        expect(account.orders.count).to eq(1)
        expect(json).to include_json(order: { order_number: 25, customer_id: customer.id })
      end
    end
    context "with incorrect params" do
      it "rejects request" do
        params = {
          order: {
            customer_id: customer.id,
            order_number: nil
          }
        }
        post "/api/v1/orders", params: params, headers: headers
        expect(account.orders.count).to eq(0)
        expect(json).to include_json(messages: ["Order number can't be blank"])
      end
    end
  end

  describe 'GET /api/v1/orders/:id' do
    context "with existing order" do
      it "returns the order" do
        get "/api/v1/orders/#{order.id}", headers: headers
        expect(json).to include_json(order: {})
        expect(response).to have_http_status(:ok)
      end
    end
    context "with a non-existent order" do
      it "returns the 404" do
        get "/api/v1/orders/0", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
