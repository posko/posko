require 'rails_helper'

RSpec.describe ProductCreator, :type => :service do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:product_creator) { ProductCreator.new(title: "bag", price: 1000, account: account, product_type: product_type, user: user) }
  describe '#process' do
    context "with regular type" do
      let(:product_type){ "regular" }
      before { product_creator.process }
      it "creates product" do
        expect(account.products.count).to eq(1)
        expect(product_creator.product.product_type).to eq("regular")
        expect(account.products.first.variants.count).to eq(1)
      end
    end
    context "with regular type" do
      let(:product_type){ "composite" }
      before { product_creator.process }
      it "creates product" do
        expect(account.products.count).to eq(1)
        expect(product_creator.product.product_type).to eq("composite")
        expect(account.products.first.variants.count).to eq(1)
      end
    end
  end
end
