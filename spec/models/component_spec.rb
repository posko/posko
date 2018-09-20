require 'rails_helper'

RSpec.describe Component, type: :model do
  let(:component) { create(:component) }

  it 'has a valid factory' do
    expect(build(:component)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:variant) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:cost) }
    it { is_expected.to validate_numericality_of(:quantity) }
    it { is_expected.to validate_numericality_of(:cost) }
  end
  #
  # describe 'scopes' do
  # end
  #
  # describe 'callbacks' do
  # end
  #
  # describe 'public instance methods' do
  # end
  #
  # describe 'public class methods' do
  # end
end
