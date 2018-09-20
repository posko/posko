require 'rails_helper'

RSpec.describe InvoiceCreationService do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:product) { create(:product, account: account) }
  let(:variant) { product.variants.create(price: 100, title: 'Large') }
  let(:customer) { create(:customer, account: account) }

  describe '#perform' do
    let(:params) do
      {
        customer_id: customer_id,
        invoice_number: '1232',
        user: user,
        account: account,
        invoice_lines: invoice_lines
      }
    end
    let(:invoice_lines) do
      [
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
          title: variant.title
        }
      ]
    end

    context 'correct params' do
      let(:customer_id) { customer.id }
      it 'creates an invoice' do
        service = InvoiceCreationService.new(params)
        expect(service).to be_valid
        expect(service.perform).to be_truthy
        invoice = service.invoice
        expect(service).to be_truthy
        expect(service).to be_performed
        expect(account.invoice_lines.count).to be(2)
        expect(invoice.total_line_items_price).to eq(303)
        expect(invoice.total_weight).to eq(2)
      end
    end

    # TODO: this chunk doesn't do anything yet
    # context "faulty params" do
    #   let(:invoice_number) { nil }
    #   it "returns false" do
    #     service = InvoiceCreationService.perform(params)
    #     expect(service.valid?).to be_falsey
    #   end
    # end
  end
end
