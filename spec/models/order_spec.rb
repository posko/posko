require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:product) { create(:product) }
  let(:variant) { product.variants.create(price: 100, title: "Large") }
  let(:customer) { create(:customer) }
  let(:order) { create(:order, customer: customer, account: customer.account) }
  describe "#create" do
    before { order }
    it "creates new order " do
      expect(customer.orders.count).to eq(1)
      expect(customer.orders)
    end
  end
  describe "validations" do
    subject { order }
    it { is_expected.to validate_presence_of(:order_number) }
    it { is_expected.to validate_presence_of(:total_line_items_price) }
    it { is_expected.to validate_presence_of(:total_discounts) }
    it { is_expected.to validate_presence_of(:subtotal) }
    it { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_presence_of(:total_tax) }
    it { is_expected.to validate_presence_of(:total_weight) }
  end
  describe "associations" do
    it { expect(order).to belong_to(:user) }
    it { expect(order).to belong_to(:account) }
    it { expect(order).to belong_to(:customer) }
    # it { expect(user).to have_many(:variants) }
  end
  describe "#recompute_values" do
    it "recomputes values and save itself" do
      order.order_lines.create(product: product, variant: variant, price: 100, title: "Large")
      order.recompute_values
      expect(order.total_line_items_price).to eq(100)
      order.order_lines.create(product: product, variant: variant, price: 50, title: "small")
      order.recompute_values
      expect(order.total_line_items_price).to eq(150)
    end
  end
  # describe "#recompute callback" do
  #   subject { create(:order) }
  #   it { is_expected.to callback(:compute_values).before(:validation).on(:create) }
  # end
end
