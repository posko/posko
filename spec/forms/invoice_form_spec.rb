require 'rails_helper'

RSpec.describe InvoiceForm, type: :form do
  let(:invoice_form) do
    InvoiceForm.new(
      customer_id: customer.id,
      invoice_lines: invoice_lines,
      invoice_number: invoice_number,
      subtotal: subtotal,
      user: create(:user)
    )
  end
  let(:customer) { create(:customer) }
  let(:invoice_number) { "00001"}
  let(:subtotal) { 202 }
  let(:invoice_lines) do
    [
      {
        variant_id: 1,
        product_id: 1,
        price: 101,
        title: "White Bag"
      },
      {
        variant_id: 2,
        product_id: 1,
        price: 101,
        title: "Blue Bag"
      }
    ]
  end


  describe '#save' do
    before { allow(invoice_form).to receive(:service_object).and_return(double(perform: true)) }
    context "with correct input" do
      it { expect(invoice_form.save).to be_truthy }
    end
  end

  describe "validations" do
    it { expect(invoice_form).to validate_presence_of(:invoice_lines) }
    it { expect(invoice_form).to validate_presence_of(:invoice_number) }
    it { expect(invoice_form).to validate_numericality_of(:invoice_number) }
    it { expect(invoice_form).to validate_presence_of(:subtotal) }
    it { expect(invoice_form).to validate_with(SubtotalValidator) }

    context "with incorrect subtotal" do
      let(:subtotal) { 1 }
      it { expect(invoice_form).to be_invalid }
    end

    context "with incorrect subtotal" do
      let(:subtotal) { 1 }
      it { expect(invoice_form).to be_invalid }
    end
  end

end
