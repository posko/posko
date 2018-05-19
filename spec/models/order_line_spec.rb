require 'rails_helper'

RSpec.describe OrderLine, type: :model do
  let(:product) { create(:product) }
  let(:variant) { product.variants.create(price: 100, title: "Large") }
  let(:order) { create(:order) }
  let(:order_line) { order.order_lines.create(product: product, variant: variant, price: 100, title: "Large") }
  describe "create order_line" do
    it "add an order_line" do
      order.order_lines.create(product: product, variant: variant, price: 100, title: "Large")
      expect(order.total_line_items_price).to eq(100)
      order.order_lines.create(product: product, variant: variant, price: 50, title: "Small")
      expect(order.order_lines.count).to eq(2)
      expect(order.total_line_items_price).to eq(150)
    end
  end
  describe "validations" do
    subject { variant }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
  end
  describe "associations" do
    it { expect(order_line).to belong_to(:order) }
    it { expect(order_line).to belong_to(:product) }
    it { expect(order_line).to belong_to(:variant) }
  end
  describe "#recompute order" do
    subject { order_line }
    it { is_expected.to callback(:recompute_order).after(:create) }
  end
end
