require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:customer) { create(:customer) }
  let(:order) { create(:order) }
  let(:transaction) { order.transactions.create(amount: 100, transaction_type: "sale", customer: customer) }
  describe "create transaction" do
    before { transaction }
    it "adds new transaction" do
      puts transaction.errors.full_messages

      expect(transaction.persisted?).to be_truthy
      expect(transaction.transaction_type).to eq("sale")
      expect(transaction.amount).to eq(100)

      expect(order.transactions.count).to eq(1)
    end
  end
  describe "validations" do
    subject { transaction }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:transaction_type) }
  end
  describe "associations" do
    it { is_expected.to belong_to(:order) }
  end
end
