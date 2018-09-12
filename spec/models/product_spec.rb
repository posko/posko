require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }
  describe "#create" do
    context "regular" do
      let(:product) { create(:product, product_type: :regular) }
      it " adds product with default variant" do
        expect(product.variants.count).to eq(0)
      end
    end
    context "regular" do
      let(:product) { create(:product, :composite) }
      # should only contain 1 variant with type :composite
    end
  end
  describe "validations" do
    subject { product }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:account_id) }
    it "validates composite_variant_count to be 1" do
      product = create(:product, :composite)
      product.variants.create(attributes_for(:variant))
      expect(product).to be_composite
      expect(product).to be_valid
      product.variants.new(attributes_for(:variant))
      expect(product).to be_invalid
      expect(product.variants.count).to eq(1)
      expect(product.errors.full_messages).to include('Composite product should only have 1 variant')
    end
  end
  describe "associations" do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to have_many(:variants) }
    it { is_expected.to have_many(:invoice_lines) }
    it { is_expected.to have_many(:components) }
  end
end
