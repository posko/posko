require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { create(:role) }

  describe 'Factory' do
    it 'creates necessary data' do
      expect(role).to be_present
      expect(Role.count).to eq(1)
    end
  end
  describe 'Associations' do
    it { is_expected.to have_many(:user_roles) }
    it { is_expected.to have_many(:users).through(:user_roles) }
  end
end
