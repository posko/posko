require 'rails_helper'

RSpec.describe OptionValueVariant, type: :model do
  let(:option_value_variant) { create(:option_value_variant) }

  it 'has a valid factory' do
    expect(create(:option_value_variant)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:variant) }
    it { is_expected.to belong_to(:option_value) }
  end
end
