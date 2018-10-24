require 'rails_helper'
require 'pdf/inspector'
RSpec.describe BarcodesPdf, type: :document do
  describe '#generate' do
    let(:variants) { Variant.all }
    let(:inspector) { PDF::Inspector::Text.analyze pdf }
    let(:pdf) { described_class.new(variants: variants).render }

    before do
      product = create(:product, title: 'Bread')
      create(:variant, title: 'Bread', product: product)
    end

    it { expect(inspector.strings).to include('Bread') }
  end
end
