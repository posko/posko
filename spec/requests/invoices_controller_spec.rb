require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:customer) { create(:customer, account: account) }
  let(:invoice) { create(:invoice, account: user.account, user: user) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }
  describe 'GET /api/v1/invoices' do
    it "returns list of invoices" do
      invoice
      get "/api/v1/invoices", headers: headers
      expect(account.invoices.count).to eq(1)
      expect(json).to include_json(invoices: [])
    end
  end

  describe 'POST /api/v1/invoices' do
    context "with correct params" do
      it "creates a invoice" do
        params = {
          invoice: {
            customer_id: customer.id,
            invoice_number: 25
          }
        }
        post "/api/v1/invoices", params: params, headers: headers
        expect(account.invoices.count).to eq(1)
        expect(json).to include_json(invoice: { invoice_number: 25, customer_id: customer.id })
      end
    end
    context "with incorrect params" do
      it "rejects request" do
        params = {
          invoice: {
            customer_id: customer.id,
            invoice_number: nil
          }
        }
        post "/api/v1/invoices", params: params, headers: headers
        expect(account.invoices.count).to eq(0)
        expect(json).to include_json(messages: ["Invoice number can't be blank"])
      end
    end
  end

  describe 'GET /api/v1/invoices/:id' do
    context "with existing invoice" do
      it "returns the invoice" do
        get "/api/v1/invoices/#{invoice.id}", headers: headers
        expect(json).to include_json(invoice: {})
        expect(response).to have_http_status(:ok)
      end
    end
    context "with a non-existent invoice" do
      it "returns the 404" do
        get "/api/v1/invoices/0", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
