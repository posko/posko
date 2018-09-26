require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product, title: 'Leather Bag') }

  describe '#create' do
    describe 'regular' do
      let(:product) { create(:product, product_type: :regular) }

      it 'adds product with default variant' do
        expect(product.variants.count).to eq(0)
      end
    end
    # describe 'composite' do
    #   let(:product) { create(:product, :composite) }
    #   # should only contain 1 variant with type :composite
    # end
  end

  describe 'validations' do
    subject { product }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:account_id) }
    it 'validates uniqueness of handle' do
      product
      new_product = create(:product, title: 'Leather Bag',
                                     account: product.account)
      expect(new_product.handle).to eq('leather-bag-1')
    end
    it 'validates composite_variant_count to be 1' do
      product = create(:product, :composite)
      product.variants.create(attributes_for(:variant))
      expect(product).to be_composite
      expect(product).to be_valid
      product.variants.new(attributes_for(:variant))
      expect(product).to be_invalid
      expect(product.variants.count).to eq(1)
      expect(product.errors.full_messages)
        .to include('Composite product should only have 1 variant')
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to have_many(:variants) }
    it { is_expected.to have_many(:invoice_lines) }
    it { is_expected.to have_many(:components) }
  end

  describe 'callbacks' do
    it do
      expect(product).to callback(:create_unique_handle).before(:validation)
    end
  end

  describe 'model' do
    it { is_expected.to accept_nested_attributes_for(:variants) }
  end

  describe 'handle' do
    before { product }

    it { expect(product.handle).to eq('leather-bag') }
    context 'with existing handle' do
      let(:product2) do
        create(:product, account: product.account, title: 'Leather Bag')
      end
      let(:product3) do
        create(:product, account: product.account, title: 'Leather Bag')
      end

      before do
        product
        product2
        product3
      end

      it { expect(product2.handle).to eq('leather-bag-1') }
      it { expect(product3.handle).to eq('leather-bag-2') }
      it { expect(product.reload.handle_count).to eq(2) }
    end
  end
end
