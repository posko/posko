require 'rails_helper'

RSpec.describe InvoiceForm, type: :form do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:product) { create(:product, account: account) }
  let(:variant) { product.variants.create(price: 100, title: 'Large') }
  let(:customer) { create(:customer, account: account) }

  let(:invoice_form) do
    InvoiceForm.new(
      customer: customer_params,
      invoice_lines: invoice_lines,
      invoice_number: invoice_number,
      subtotal: subtotal,
      user: user,
      account: user.account
    )
  end
  let(:invoice_number) { '00001' }
  let(:subtotal) { 303 }
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
        title: variant.title,
        quantity: 1,
        weight: 1
      }
    ]
  end
  let(:customer_params) { { id: customer.id } }

  describe '#save' do
    # before { allow(invoice_form).to receive(:service_object).
    # and_return(double(perform: true)) }
    context 'with correct input' do
      before { invoice_form.save }

      it { expect(invoice_form.save).to be_truthy }
    end
  end

  describe 'validations' do
    it { expect(invoice_form).to validate_presence_of(:invoice_lines) }
    it { expect(invoice_form).to validate_presence_of(:invoice_number) }
    it { expect(invoice_form).to validate_numericality_of(:invoice_number) }
    it { expect(invoice_form).to validate_presence_of(:subtotal) }
    it { expect(invoice_form).to validate_with(InvoiceValidator) }
  end
end
