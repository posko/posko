require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:shift) { create(:shift) }

  describe 'Factory' do
    it 'creates necessary data' do
      expect(shift).to be_present
      expect(Shift.count).to eq(1)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:invoices) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:starting_cash) }
  end
end
