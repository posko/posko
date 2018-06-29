require 'rails_helper'

RSpec.describe InvoiceLine, type: :model do
  let(:product) { create(:product) }
  let(:variant) { product.variants.create(price: 100, title: "Large") }
  let(:invoice) { create(:invoice) }
  let(:invoice_line) { invoice.invoice_lines.create(product: product, variant: variant, price: 100, title: "Large") }
  describe "create invoice_line" do
    it "add an invoice_line" do
      invoice.invoice_lines.create(product: product, variant: variant, price: 100, title: "Large")
      expect(invoice.total_line_items_price).to eq(100)
      invoice.invoice_lines.create(product: product, variant: variant, price: 50, title: "Small")
      expect(invoice.invoice_lines.count).to eq(2)
      expect(invoice.total_line_items_price).to eq(150)
    end
  end
  describe "validations" do
    subject { variant }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
  end
  describe "associations" do
    it { is_expected.to belong_to(:invoice) }
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:variant) }
  end
  describe "#recompute invoice" do
    subject { invoice_line }
    it { is_expected.to callback(:recompute_invoice).after(:create) }
  end
end
