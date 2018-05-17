require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:customer) { create(:customer, account: user.account) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }
  describe 'GET /api/v1/customers' do
    it "returns list of customers" do
      create(:customer, account: account)
      get "/api/v1/customers", headers: headers
      expect(account.customers.count).to eq(1)
      expect(json).to include_json(customers: [])
    end
  end

  describe 'POST /api/v1/customers' do
    context "with correct params" do
      it "returns list of customers" do
        params = {
          customer: {
            first_name: "Cardo",
            last_name: "Dalisay",
            email: "cardo@dalisay.com"
          }
        }
        post "/api/v1/customers", params: params, headers: headers
        expect(account.customers.count).to eq(1)
        expect(json).to include_json(customer: {first_name: "Cardo", last_name: "Dalisay"})
      end
    end
  context "with incorrect params" do
    it "returns list of customers" do
      params = {
        customer: {
          first_name: nil,
          last_name: nil,
          email: nil
        }
      }
      post "/api/v1/customers", params: params, headers: headers
      expect(account.customers.count).to eq(0)
      expect(json).to include_json(messages: ["First name can't be blank", "Last name can't be blank"])
    end
  end
  end
end
