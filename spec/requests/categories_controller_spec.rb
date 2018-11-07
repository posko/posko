require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:category) { create(:category, account: account) }

  let(:access_key) { user.access_keys.first }
  let(:headers) do
    token = access_key.token
    auth_token = access_key.auth_token
    { 'HTTP_AUTHORIZATION': basic_auth(token, auth_token) }
  end

  describe 'GET /api/v1/categories' do
    before do
      category
      create(:category, name: 'juice', account: account)
    end

    context 'when retrieving all categories' do
      before { get '/api/v1/categories', headers: headers }

      it 'returns list of categories' do
        expect(json['categories'].count).to eq(2)
      end
    end
  end

  describe 'GET /api/v1/categories/count' do
    before { category }

    it 'counts categories' do
      get '/api/v1/categories/count', headers: headers
      expect(response).to have_http_status(:ok)
      expect(json).to include_json(count: 1)
    end
  end

  describe 'GET /api/v1/categories/:id' do
    context 'with existing category' do
      it 'returns the category' do
        get "/api/v1/categories/#{category.id}", headers: headers
        expect(json).to include_json(category: {})
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with a non-existent category' do
      it 'returns the 404' do
        get '/api/v1/categories/0', headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
