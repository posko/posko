require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  let(:account) { create(:account) }
  let(:user) do
    create(:user,
           password: 'pass',
           account: account,
           access_key_count: 0)
  end
  let(:access_key) { user.access_keys.first }
  let(:successful_sign_in) do
    { user: {
      email: user.email,
      token: access_key.token,
      auth_token: access_key.auth_token,
      created_at: user.created_at.as_json
    } }
  end
  let(:failed_sign_in) { { messages: ['Incorrect credentials'] } }

  describe 'POST sign_in' do
    let(:params) do
      { account_name: account.name, email: user.email, password: password }
    end

    context 'with correct credentials' do
      let(:password) { 'pass' }

      it 'authenticates user' do
        post '/api/v1/sign_in.json', params: params
        expect(json).to include_json(successful_sign_in)
      end
    end

    context 'with incorrect credentials' do
      let(:password) { 'wrong pass' }

      it 'does not authenticates user' do
        post '/api/v1/sign_in.json', params: params
        expect(json).to include_json(failed_sign_in)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
# require 'rails_helper'

# RSpec.describe "Auth", type: :request do
#   let(:user) { create(:user, email: "a@a.com", password: "pass") }
#   let(:successful_sign_in) { { user: {
#                                 email: user.email,
#                                 token: user.token} } }
#   let(:failed_sign_in) { { messages: [ "Invalid Credentials"] } }
#   describe 'POST /sign_in' do
#     context "with correct credentials" do
#         before do
#           user && post('/api/v1/auth/sign_in',
#             params: { email: 'a@a.com', password: 'pass' })
#         end
#       it "returns user" do
#         expect(json).not_to be_empty
#         expect(response).to have_http_status(:ok)
#         expect(json).to include_json(successful_sign_in)
#       end
#     end
#     context "with incorrect credentials" do
#       before { post('/api/v1/auth/sign_in',
#                params: {email: 'a@a.com', password: "wrong_pass"}) }
#       it "returns user" do
#         expect(json).not_to be_empty
#         expect(response).to have_http_status(401)
#         expect(json).to include_json(failed_sign_in)
#       end
#     end
#   end
# end
