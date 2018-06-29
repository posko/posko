require 'rails_helper'

RSpec.describe Api::V1::InvoiceLinesController, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:customer) { create(:customer, account: account) }
  let(:invoice) { create(:invoice, account: user.account, user: user) }
  let(:access_key) { user.access_keys.first }
  let(:headers) { { 'HTTP_AUTHORIZATION': basic_auth(access_key.token, access_key.auth_token) } }

  let(:invoice_line) { create(:invoice_line, price: 100, title: "Large", invoice: invoice) }
  describe 'GET /api/v1/invoices/:invoice_id/invoice_lines' do
    it "returns list of invoices" do
      invoice_line
      get "/api/v1/invoices/#{invoice.id}/invoice_lines", headers: headers
      expect(invoice.invoice_lines.count).to eq(1)
      expect(json).to include_json(invoice_lines: [])
    end
  end

  describe 'POST /api/v1/invoice/:invoice_id/invoice_lines' do
    let(:variant) { create(:variant, product: product, price: 200) }
    let(:product) { create(:product, account: account) }
    let(:params) do
      {
        invoice_line: {
          title: variant.title,
          price: price,
          variant_id: variant.id,
          product_id: product.id
        }
      }
    end
    before { post "/api/v1/invoices/#{invoice.id}/invoice_lines", params: params, headers: headers }
    context "with correct params" do
      let(:price) { 200 }
      it "creates a invoice" do
        expect(invoice.invoice_lines.count).to eq(1)
        expect(response).to have_http_status(:ok)
        expect(json).to include_json(invoice_line: { price: "200.0" }, invoice: { total_line_items_price: "200.0" })
      end
    end

    context "with incorrect params" do
      let(:price) { nil }
      it "rejects request" do
        expect(invoice.invoice_lines.count).to eq(0)
        expect(json).to include_json(messages: ["Price can't be blank"])
      end
    end
  end

  describe 'GET /api/v1/invoice_lines/:id' do
    context "with existing invoice" do
      it "returns the invoice" do
        get "/api/v1/invoice_lines/#{invoice_line.id}", headers: headers
        expect(json).to include_json(invoice_line: {})
        expect(response).to have_http_status(:ok)
      end
    end
    context "with a non-existent invoice" do
      it "returns the 404" do
        get "/api/v1/invoice_lines/0", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
