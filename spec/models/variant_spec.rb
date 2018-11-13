require 'rails_helper'

RSpec.describe Variant, type: :model do
  let(:product) { create(:product) }
  let(:variant) { product.variants.create(price: 100) }

  describe 'create variant' do
    before { product.variants.create(price: 100) }

    it 'adds new variant' do
      expect(product.variants.count).to eq(2)
    end
  end

  describe 'validations' do
    subject { variant }

    it { is_expected.to validate_presence_of(:price) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it do
      expect(variant).to have_many(:option_values)
        .through(:option_value_variants)
    end

    it { is_expected.to have_many(:invoice_lines) }
    it { is_expected.to have_many(:components) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:variant_type) }
    it { is_expected.to define_enum_for(:selling_policy) }
  end
end
