require 'rails_helper'

RSpec.describe ServiceObject do
  let(:custom_service_class) do
    Class.new(ServiceObject) do
      def perform_service
        true
      end

      def simulate_an_error
        add_error 'sample error'
      end
    end
  end
  let(:performless_service_class) { Class.new(ServiceObject) {} }
  let(:custom_service) { custom_service_class.new }

  describe '.perform' do
    context 'with correct definition' do
      it 'performs its service' do
        service = custom_service_class.perform
        expect(service).to be_instance_of(custom_service_class)
      end
    end

    context 'without #perform definition' do
      it 'raise and error' do
        expect do
          performless_service_class.perform
        end.to raise_exception.with_message(
          "'perform_service' method Not implemented"
        )
      end
    end
  end

  describe '#errors' do
    before { custom_service.simulate_an_error }

    it 'adds error' do
      expect(custom_service.errors.count).to eq(1)
    end
  end
end
