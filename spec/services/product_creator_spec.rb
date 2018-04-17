require 'rails_helper'

RSpec.describe ProductCreator, :type => :service do
  let(:account) { create(:account) }
  describe '#process' do
    before { ProductCreator.new(title: "bag", price: 1000, account: account).process }
    it "creates product" do
      expect(account.products.count).to eq(1)
      expect(account.products.first.variants.count).to eq(1)
    end
  end
end
