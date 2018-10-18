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
        invoice_number: invoice_number,
        user: user,
        account: account,
        invoice_lines: invoice_lines,
        customer: customer_params
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
    let(:invoice_number) { '19921' }
    let(:customer_params) { { id: customer.id } }
    let(:service) { described_class.new(params) }

    context 'with correct params' do
      it 'creates an invoice' do
        expect(service).to be_valid
        expect(service.perform).to be_truthy
        invoice = service.invoice
        expect(service).to be_truthy
        expect(service).to be_performed
        expect(account.invoice_lines.count).to be(2)
        expect(invoice.total_line_items_price).to eq(303)
        expect(invoice.subtotal).to eq(303)
        expect(invoice.total_weight).to eq(2)
      end
    end

    context 'with faulty params' do
      let(:invoice_number) { nil }

      it 'returns false' do
        service.perform
        expect(service).not_to be_valid
      end
    end

    context 'with an exeception' do
      let(:invoice_number) { nil }

      before { allow(service).to receive(:valid?).and_return(true) }

      it { expect(service.perform).to be_falsey }
    end

    context 'with new customer' do
      let(:customer_params) do
        {
          first_name: 'Kaneki',
          last_name: 'Ken',
          email: 'kaneki@ken.com'
        }
      end

      before { service.perform }

      it { expect(Customer.count).to eq(1) }
      it { expect(Customer.first).to eq(service.customer) }
    end
  end
end
