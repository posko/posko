require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { create(:customer, first_name: 'Pedro') }

  describe 'validations' do
    subject { customer }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to belong_to(:default_address) }
    # it { expect(customer).to have_one(:customer_account) }
  end
end
