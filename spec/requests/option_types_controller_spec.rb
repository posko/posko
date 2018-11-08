require 'rails_helper'

RSpec.describe Api::V1::OptionTypesController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:product) { create(:product, account: account) }
  let(:option_type) { create(:option_type, product: product, name: 'Size') }

  let(:access_key) { user.access_keys.first }
  let(:headers) do
    token = access_key.token
    auth_token = access_key.auth_token
    { 'HTTP_AUTHORIZATION': basic_auth(token, auth_token) }
  end

  describe 'GET /api/v1/option types' do
    before do
      option_type
      create(:option_type, name: 'juice', product: product)
    end

    context 'when retrieving all option types' do
      before do
        get "/api/v1/products/#{product.id}/option_types", headers: headers
      end

      it 'returns list of option types' do
        expect(json['option_types'].count).to eq(2)
      end
    end
  end

  describe 'GET /api/v1/option_types/count' do
    before { option_type }

    it 'counts option types' do
      get "/api/v1/products/#{product.id}/option_types/count", headers: headers
      expect(response).to have_http_status(:ok)
      expect(json).to include_json(count: 1)
    end
  end

  describe 'GET /api/v1/option_types/:id' do
    context 'with existing option_type' do
      it 'returns the option_type' do
        get "/api/v1/option_types/#{option_type.id}", headers: headers
        expect(json).to include_json(option_type: {})
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with a non-existent option_type' do
      it 'returns the 404' do
        get '/api/v1/option_types/0', headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
