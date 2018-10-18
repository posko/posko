require 'rails_helper'

RSpec.describe ExporterObject, type: :exporter do
  let(:exporter_class) do
    Class.new(ExporterObject) do
      attr_reader :name
      def initialize(name)
        @name = name
      end

      def perform
        @name = "Hi #{name}"
        self
      end
    end
  end

  describe '.perform' do
    let(:exporter) { exporter_class.perform('John') }

    it { expect(exporter.name).to eq('Hi John') }
  end

  describe '#perform' do
    it do
      expect { Class.new(ExporterObject).perform }.to raise_error(StandardError)
    end
  end
end
