require 'rails_helper'
require 'pdf/inspector'
RSpec.describe PdfObject, type: :document do
  let(:pdf_class) do
    Class.new(described_class) do
      def initialize
        super
        hello_world
      end

      def hello_world
        text 'Hello World!'
      end
    end
  end

  describe '#generate' do
    let(:inspector) { PDF::Inspector::Text.analyze pdf }
    let(:pdf) { pdf_class.new.render }

    it { expect(inspector.strings).to include('Hello World!') }
  end
end
