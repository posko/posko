require 'rails_helper'

RSpec.describe OptionValue, type: :model do
  let(:option_value) { create(:option_value) }

  describe 'Factory' do
    it 'creates necessary data' do
      expect(option_value).to be_present
      expect(OptionValue.count).to eq(1)
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:option_type) }
    it { is_expected.to have_many(:variants) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
