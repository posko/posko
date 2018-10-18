require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:customer) { create(:customer, account: account) }
  let(:invoice) { create(:invoice, account: user.account, user: user) }
  let(:product) { create(:product, account: account) }
  let(:variant) { product.variants.create(price: 100, title: 'Large') }
  let(:access_key) { user.access_keys.first }

  let(:headers) do
    token = access_key.token
    auth_token = access_key.auth_token
    { 'HTTP_AUTHORIZATION': basic_auth(token, auth_token) }
  end

  describe 'GET /api/v1/invoices' do
    it 'returns list of invoices' do
      invoice
      get '/api/v1/invoices', headers: headers
      expect(response).to have_http_status(:ok)
      expect(account.invoices.count).to eq(1)
      expect(json).to include_json(invoices: [])
    end
  end

  describe 'POST /api/v1/invoices' do
    let(:params) do
      {
        invoice: {
          customer: { id: customer.id },
          invoice_number: 25,
          subtotal: 303,
          invoice_lines: [
            {
              variant_id: variant.id,
              product_id: product.id,
              price: 101,
              title: variant.title,
              quantity: 2,
              weight: 1
            },
            {
              variant_id: variant.id,
              product_id: product.id,
              price: 101,
              title: variant.title,
              quantity: 1,
              weight: 1
            }
          ]
        }
      }
    end

    context 'with correct params' do
      it 'creates a invoice' do
        post '/api/v1/invoices', params: params, headers: headers
        expect(account.invoices.count).to eq(1)
        expect(json).to include_json(invoice: {
                                       invoice_number: 25,
                                       customer_id: customer.id,
                                       total_weight: '3.0'
                                     })
      end
    end

    context 'with incorrect params' do
      it 'rejects request' do
        params[:invoice][:invoice_number] = nil
        post '/api/v1/invoices', params: params, headers: headers
        expect(account.invoices.count).to eq(0)
        expect(json).to include_json(
          messages: ["Invoice number can't be blank"]
        )
      end
    end
  end

  describe 'GET /api/v1/invoices/:id' do
    context 'with existing invoice' do
      it 'returns the invoice' do
        get "/api/v1/invoices/#{invoice.id}", headers: headers
        expect(json).to include_json(invoice: {})
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with a non-existent invoice' do
      it 'returns the 404' do
        get '/api/v1/invoices/0', headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
