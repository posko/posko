require 'rails_helper'

RSpec.describe ProductForm, type: :form do
  let(:user) { create(:user) }
  let(:account) { user.account }

  let(:form) do
    described_class.new(
      created_by: user,
      title: 'Bag',
      price: 2500,
      cost: 1680,
      sku: '1000011',
      barcode: '1001'
    )
  end

  describe '#save' do
    context 'with correct input' do
      before { form.save }

      it { expect(Product.count).to eq 1 }
      it { expect(Variant.count).to eq 1 }
    end
  end

  describe '#persisted?' do
    let(:product) { create(:product) }

    it { expect(described_class.new(product: Product.new)).not_to be_persisted }
    it { expect(described_class.new(product: product)).to be_persisted }
  end

  describe 'validations' do
    it { expect(form).to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
  end
end
