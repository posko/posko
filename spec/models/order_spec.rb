require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:customer) { create(:customer) }
  let(:order) { create(:order, customer: customer, account: customer.account) }
  describe "#create" do
    before { order }
    it "creates new order " do
      expect(customer.orders.count).to eq(1)
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
end
