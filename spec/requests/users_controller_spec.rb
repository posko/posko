require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user, account: user.account) }
  let(:access_key) { user.access_keys.first }

  let(:headers) do
    token = access_key.token
    auth_token = access_key.auth_token
    { 'HTTP_AUTHORIZATION': basic_auth(token, auth_token) }
  end

  describe 'GET /api/v1/users' do
    it 'returns list of users' do
      user2 # invoke to create user before request
      get '/api/v1/users', headers: headers
      expect(user.account.users.count).to eq(2)
      expect(json).to include_json(users: [])
    end
  end

  describe 'GET /api/v1/users/count' do
    it 'counts users' do
      user2 # invoke to create user before request
      get '/api/v1/users/count', headers: headers
      expect(json).to include_json(count: 2)
    end
  end
end
