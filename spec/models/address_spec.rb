require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:customer) { create(:customer, first_name: 'Pedro') }
  let(:address) { create(:address, first_name: 'Pedro', customer: customer) }

  describe 'validations' do
    subject { address }

    it { is_expected.to validate_presence_of(:address1) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:customer) }
    # it { expect(address).to have_one(:address_account) }
  end
end
