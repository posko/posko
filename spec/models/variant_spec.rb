require 'rails_helper'

RSpec.describe Variant, type: :model do
  let(:product) { create(:product) }
  let(:variant) { product.variants.create(price: 100, title: "Large") }
  describe "create variant" do
    before { product.variants.create(price: 100, title: "Large")}
    it "adds new variant" do
      expect(product.variants.count).to eq(1)
    end
  end
  describe "validations" do
    subject { variant }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
  end
  describe "associations" do
    it { expect(variant).to belong_to(:product) }
  end
end
