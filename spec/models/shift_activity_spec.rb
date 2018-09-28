require 'rails_helper'

RSpec.describe ShiftActivity, type: :model do
  let(:shift_activity) { create(:shift_activity) }

  describe 'Factory' do
    it 'creates necessary data' do
      expect(shift_activity).to be_present
      expect(ShiftActivity.count).to eq(1)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:shift) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:amount) }
  end

  describe 'model' do
    it { is_expected.to define_enum_for(:shift_activity_type) }
  end
end
