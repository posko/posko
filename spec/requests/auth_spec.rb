require "rails_helper"

RSpec.describe "Auth", :type => :request do
  let(:account) { create(:account) }
  let(:user){ create(:user, password: "pass", account: account) }
  let(:successful_sign_in) { { user: { email: user.email, token: user.token, created_at: user.created_at.as_json} } }
  let(:failed_sign_in) { { messages: ["Incorrect credentials"] } }
  context "with correct credentials" do
    it "authenticates user" do
      post "/api/v1/sign_in.json", params: { account_name: account.name, email: user.email, password: "pass" }

      expect(json).to include_json(successful_sign_in)
    end
      it "does not authenticates user" do
        post "/api/v1/sign_in.json", params: { account_name: account.name, email: user.email, password: "wrongpass" }
        expect(json).to include_json(failed_sign_in)
      end
  end
end
# require 'rails_helper'

# RSpec.describe "Auth", type: :request do
#   let(:user) { create(:user, email: "a@a.com", password: "pass") }
#   let(:successful_sign_in) { { user: { email: user.email, token: user.token} } }
#   let(:failed_sign_in) { { messages: [ "Invalid Credentials"] } }
#   describe 'POST /sign_in' do
#     context "with correct credentials" do
#       before { user && post('/api/v1/auth/sign_in', params: {email: "a@a.com", password: "pass"}) }
#       it "returns user" do
#         expect(json).not_to be_empty
#         expect(response).to have_http_status(200)
#         expect(json).to include_json(successful_sign_in)
#       end
#     end
#     context "with incorrect credentials" do
#       before { post('/api/v1/auth/sign_in', params: {email: 'a@a.com', password: "wrong_pass"}) }
#       it "returns user" do
#         expect(json).not_to be_empty
#         expect(response).to have_http_status(401)
#         expect(json).to include_json(failed_sign_in)
#       end
#     end
#   end
# end
