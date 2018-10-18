require 'rails_helper'

RSpec.describe FormObject, type: :model do
  let(:custom_form_class) do
    Class.new(FormObject) do
      attr_accessor :title
      def persist!
        true
      end

      def update_attributes(_options = {})
        true
      end
    end
  end

  let(:custom_form) { custom_form_class.new(title: 'Product') }

  it { expect(custom_form.title).to eq('Product') }

  describe '#save' do
    context 'with correct data' do
      it { expect(custom_form.save).to be_truthy }
    end

    context 'with an exception' do
      it 'raises an exception' do
        my_class = custom_form_class.new title: 'Product'
        allow(my_class).to receive(:valid?)
          .and_raise(ActiveRecord::RecordInvalid)

        expect(my_class.save).to eq(false)
      end
    end
  end

  describe '#save!' do
    it 'raises an exception' do
      my_class = custom_form_class.new title: 'Product'
      allow(my_class).to receive(:valid?).and_return(false)

      expect { my_class.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#update' do
    context 'with correct data' do
      it { expect(custom_form.update(title: 'New')).to be_truthy }
    end

    context 'with an exception' do
      it 'raises an exception' do
        my_class = custom_form_class.new title: 'Product'
        allow(my_class).to receive(:valid?)
          .and_raise(ActiveRecord::RecordInvalid)

        expect(my_class.update).to eq(false)
      end
    end
  end

  describe '#update!' do
    it 'raises an exception' do
      my_class = custom_form_class.new title: 'Product'
      allow(my_class).to receive(:valid?).and_return(false)

      expect do
        my_class.update! title: 'P'
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#perform' do
    it 'expects persist! method' do
      expect do
        Class.new(described_class).new.persist!
      end.to raise_error(StandardError)
    end

    it 'expects update_attributes method' do
      expect do
        Class.new(described_class).new.update(title: '')
      end.to raise_error(StandardError)
    end
  end
end
