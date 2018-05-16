require 'rails_helper'

RSpec.describe Api::V1::ApiController, type: :request do
  let(:user) { create(:user) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }

  describe '#current_account' do
  end

  describe '#http_basic_authenticate' do
  end

  describe '#current_user' do
    it "returns current account" do
      get "/api/v1/users", headers: headers
      expect(json).to include_json({ users: [{ id: user.id }] })
    end
  end
end
