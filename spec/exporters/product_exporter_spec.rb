require 'rails_helper'

RSpec.describe ProductExporter, type: :exporter do
  let(:product) { create(:product, title: 'Bread') }
  let(:variant) do
    create(
      :variant,
      product: product,
      sku: '1001',
      cost: 10,
      price: 12,
      barcode: '100001'
    )
  end
  let(:exporter) { described_class.new(records: Product.all) }

  describe '#perform' do
    let(:result) { exporter.csv.split("\n") }

    before do
      variant
      exporter.perform
    end

    it { expect(result[0]).to eq('Handle,SKU,Name,Cost,Price,Barcode') }
    it { expect(result[1]).to eq('bread,,Bread,,100.0,19999191') }
    it { expect(result[2]).to eq('bread,1001,Bread,10.0,12.0,100001') }
  end
end
