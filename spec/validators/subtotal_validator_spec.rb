require 'rails_helper'

RSpec.describe SubtotalValidator do
  let(:validatable) do
    Class.new() do
      include ActiveModel::Model
      attr_accessor :invoice_lines, :subtotal
      validates_with SubtotalValidator
      def self.model_name
        ActiveModel::Name.new(self, nil, "validatable")
      end
    end
  end
  let(:invoice_lines) { [ { price: 10, quantity: 2 }, { price: 12 } ] }
  subject { validatable.new(subtotal: subtotal, invoice_lines: invoice_lines ) }

  describe '#validate' do
    context "with correct subtotal" do
      let(:subtotal) { 32 }
      it { is_expected.to be_valid }
    end
    context "with incorrect subtotal" do
      let(:subtotal) { 10 }
      it { is_expected.to be_invalid }
    end

    context "without subtotal" do
      let(:subtotal) { nil }
      it { is_expected.to be_invalid }
    end
  end

  describe '#total_line_amount' do
  end
end
