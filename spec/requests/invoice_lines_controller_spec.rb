require 'rails_helper'

RSpec.describe Api::V1::InvoiceLinesController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:customer) { create(:customer, account: account) }
  let(:invoice) { create(:invoice, account: user.account, user: user) }
  let(:access_key) { user.access_keys.first }

  let(:headers) do
    token = access_key.token
    auth_token = access_key.auth_token
    { 'HTTP_AUTHORIZATION': basic_auth(token, auth_token) }
  end

  let(:invoice_line) do
    create(:invoice_line,
           price: 100,
           title: 'Large',
           invoice: invoice)
  end

  describe 'GET /api/v1/invoices/:invoice_id/invoice_lines' do
    it 'returns list of invoices' do
      invoice_line
      get "/api/v1/invoices/#{invoice.id}/invoice_lines", headers: headers
      expect(invoice.invoice_lines.count).to eq(1)
      expect(json).to include_json(invoice_lines: [])
    end
  end

  describe 'GET /api/v1/invoice_lines/:id' do
    context 'with existing invoice' do
      it 'returns the invoice' do
        get "/api/v1/invoice_lines/#{invoice_line.id}", headers: headers
        expect(json).to include_json(invoice_line: {})
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with a non-existent invoice' do
      it 'returns the 404' do
        get '/api/v1/invoice_lines/0', headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
