require 'rails_helper'

RSpec.describe InvoiceValidator do
  subject { validatable_object }

  let(:validatable_object) do
    validatable.new(subtotal: subtotal, invoice_lines: invoice_lines)
  end
  let(:validatable) do
    Class.new do
      include ActiveModel::Model
      attr_accessor :invoice_lines, :subtotal
      validates_with InvoiceValidator
      def self.model_name
        ActiveModel::Name.new(self, nil, 'validatable')
      end
    end
  end
  let(:invoice_lines) do
    [
      { variant_id: 1, price: 10, quantity: 2 },
      { variant_id: 2, price: 12, quantity: 1 }
    ]
  end
  let(:subtotal) { 32 }

  describe 'invoice subtotal' do
    context 'with correct subtotal' do
      it { is_expected.to be_valid }
    end
    context 'with incorrect subtotal' do
      let(:subtotal) { 10 }

      it { is_expected.to be_invalid }
    end

    context 'without subtotal' do
      let(:subtotal) { nil }

      it { is_expected.to be_invalid }
    end
  end

  describe 'invoice lines\' attributes' do
    context 'with complete attributes' do
      it { is_expected.to be_valid }
    end

    context 'with missing attributes' do
      let(:invoice_lines) do
        [
          { variant_id: 1, quantity: 2 }, # 1 missing
          { variant_id: 2, price: 12 }, # 1 missing
          {} # 3 missing
        ]
      end

      before { validatable_object.validate }
      it { is_expected.to be_invalid }
      it { expect(validatable_object.errors.count).to eq 5 }
    end
  end
end
