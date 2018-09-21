require 'rails_helper'

RSpec.describe Api::V1::AccessKeysController, type: :request do
  let(:user) { create(:user) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }

  describe 'GET /api/v1/access_keys' do
    it 'returns current account' do
      user.access_keys.create
      get '/api/v1/access_keys', headers: headers
      expect(json).to include_json(access_keys: [])
    end
  end
end
