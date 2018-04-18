require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }
  describe "#create" do
    it " adds product with default variant" do
      expect(product.variants.count).to eq(0)
    end
  end
  describe "validations" do
    subject { product }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:account_id) }
  end
  describe "associations" do
    it { expect(product).to belong_to(:account) }
    # it { expect(user).to have_many(:variants) }
  end
end
