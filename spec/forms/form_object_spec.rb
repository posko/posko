require 'rails_helper'

RSpec.describe FormObject, type: :model do
  let(:custom_form_class) do
    Class.new(FormObject) do
      attr_accessor :title
    end
  end

  describe 'anonymous class' do
    let(:custom_form) { custom_form_class.new(title: 'Product') }

    it { expect(custom_form.title).to eq('Product') }

    describe '#save!' do
      it 'raises an exception' do
        my_class = custom_form_class.new title: 'Product'
        allow(my_class).to receive(:valid?).and_return(false)

        expect { my_class.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe '#save!' do
      it 'raises an exception' do
        my_class = custom_form_class.new title: 'Product'
        allow(my_class).to receive(:valid?).and_return(false)

        expect do
          my_class.update! title: 'P'
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
