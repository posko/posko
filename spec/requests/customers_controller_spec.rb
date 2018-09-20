require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:customer) { create(:customer, account: user.account) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }
  describe 'GET /api/v1/customers' do
    it 'returns list of customers' do
      create(:customer, account: account)
      get '/api/v1/customers', headers: headers
      expect(account.customers.count).to eq(1)
      expect(json).to include_json(customers: [])
    end
  end

  describe 'POST /api/v1/customers' do
    context 'with correct params' do
      it 'creates a customer' do
        params = {
          customer: {
            first_name: 'Cardo',
            last_name: 'Dalisay',
            email: 'cardo@dalisay.com'
          }
        }
        post '/api/v1/customers', params: params, headers: headers
        expect(account.customers.count).to eq(1)
        expect(json).to include_json(customer: { first_name: 'Cardo', last_name: 'Dalisay' })
      end
    end
    context 'with incorrect params' do
      it 'rejects request' do
        params = {
          customer: {
            first_name: nil,
            last_name: nil,
            email: nil
          }
        }
        post '/api/v1/customers', params: params, headers: headers
        expect(account.customers.count).to eq(0)
        expect(json).to include_json(messages: ["First name can't be blank", "Last name can't be blank"])
      end
    end
  end

  describe 'GET /api/v1/customers/:id' do
    context 'with existing customer' do
      it 'returns the customer' do
        get "/api/v1/customers/#{customer.id}", headers: headers
        expect(json).to include_json(customer: {})
        expect(response).to have_http_status(:ok)
      end
    end
    context 'with a non-existent customer' do
      it 'returns the 404' do
        get '/api/v1/customers/0', headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
