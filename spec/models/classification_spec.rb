require 'rails_helper'

RSpec.describe Classification, type: :model do
  let(:classification) { create(:classification) }

  it 'has a valid factory' do
    expect(build(:classification)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:category) }
  end
end
