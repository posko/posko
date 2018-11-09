require 'rails_helper'

RSpec.describe OptionType, type: :model do
  let(:option_type) { create(:option_type) }

  describe 'Factory' do
    it 'creates necessary data' do
      expect(option_type).to be_present
      expect(OptionType.count).to eq(1)
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:option_values) }
  end
end
