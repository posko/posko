require 'rails_helper'

RSpec.describe Api::V1::OptionValuesController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:product) { create(:product, account: account) }
  let(:option_type) { create(:option_type, product: product, name: 'Size') }
  let(:option_value) { create(:option_value, option_type: option_type) }

  let(:access_key) { user.access_keys.first }
  let(:headers) do
    token = access_key.token
    auth_token = access_key.auth_token
    { 'HTTP_AUTHORIZATION': basic_auth(token, auth_token) }
  end

  describe 'GET /api/v1/option_values' do
    before do
      option_value
      create(:option_value, name: 'Small', option_type: option_type)
    end

    context 'when retrieving all option types' do
      let(:uri) { "/api/v1/option_types/#{option_type.id}/option_values" }

      before do
        get uri, headers: headers
      end

      it 'returns list of option types' do
        expect(json['option_values'].count).to eq(2)
      end
    end
  end

  describe 'GET /api/v1/option_types/:option_type_id/option_values/count' do
    let(:uri) { "/api/v1/option_types/#{option_type.id}/option_values/count" }

    before { option_value }

    it 'counts option types' do
      get uri, headers: headers
      expect(response).to have_http_status(:ok)
      expect(json).to include_json(count: 1)
    end
  end

  describe 'GET /api/v1/option_values/:id' do
    context 'with existing option_type' do
      it 'returns the option_type' do
        get "/api/v1/option_values/#{option_value.id}", headers: headers
        expect(json).to include_json(option_value: {})
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with a non-existent option value' do
      it 'returns the 404' do
        get '/api/v1/option_values/0', headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
