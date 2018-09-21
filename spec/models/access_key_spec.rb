require 'rails_helper'

RSpec.describe AccessKey, type: :model do
  let(:access_key) { create(:access_key) }

  describe 'tokens' do
    it 'generates random characters' do
      expect(access_key.token.size).to be(24)
      expect(access_key.auth_token.size).to be(24)
    end
  end
  describe 'validations' do
    subject { access_key }

    it { is_expected.to validate_uniqueness_of(:token) }
  end
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
