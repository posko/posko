require 'rails_helper'

RSpec.describe ShiftCalculatorService, type: :service do
  let(:shift) { create(:shift) }
  let(:service) do
    described_class.new shift: shift
  end

  describe '#perform' do
    context 'with initial data' do
      before { service.perform }

      it 'computes shift summary' do
        expect(service.paid_out).to eq(0)
        expect(service.paid_in).to eq(0)
        expect(service.payments).to eq(0)
        expect(service.cash).to eq(0)
      end
    end

    context 'with complete data' do
      let(:shift) { create(:shift, starting_cash: 100) }

      before do
        create(:invoice, subtotal: 1000, shift: shift)
        create(:shift_activity, :pay_in, amount: 500, shift: shift)
        create(:shift_activity, :pay_in, amount: 200, shift: shift)
        create(:shift_activity, :pay_out, amount: 100, shift: shift)
        service.perform
      end

      it 'computes shift summary' do
        expect(service.paid_in).to eq(700)
        expect(service.paid_out).to eq(100)
        expect(service.payments).to eq(1000)
        expect(service.cash).to eq(1900)
      end
    end
  end
end
