require 'rails_helper'
require 'pdf/inspector'
RSpec.describe BarcodesPdf, type: :document do
  describe '#generate' do
    let(:inspector) { PDF::Inspector::Text.analyze pdf }
    let(:pdf) { described_class.new.render }

    it { expect(inspector.strings).to include('Hello World!') }
  end
end
