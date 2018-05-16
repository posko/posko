require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) {create(:user)}
  let(:user2) {create(:user, account: user.account)}
  let(:access_key) { user.access_keys.first}
  let(:headers) { {'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }
  describe 'GET /api/v1/users' do
    it "returns current account" do
      user2 # invoke to create user before request
      get "/api/v1/users", headers: headers
      expect(user.account.users.count).to eq(2)
      expect(json).to include_json({users: []})
    end
  end
end
