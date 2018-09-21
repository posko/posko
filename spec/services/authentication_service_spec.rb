require 'rails_helper'

RSpec.describe AuthenticationService do
  let(:account) { create(:account, name: 'posko') }
  let(:user) do
    create(:user,
           email: 'a@a.com',
           password: 'pass',
           account: account,
           access_key_count: 0)
  end
  let(:sign_in) do
    user
    described_class.new account_name: 'posko',
                        email: 'a@a.com',
                        password: 'pass'
  end

  before { user }

  describe 'Factory' do
    it 'creates necessary data' do
      expect(user).to be_present
      expect(user.email).to eq('a@a.com')
      expect(User.count).to eq(1)
      expect(Account.count).to eq(1)
    end
  end

  describe '#process' do
    context 'with correct credentials' do
      it 'accepts user' do
        expect(sign_in.errors.count).to eq(0)
        expect(sign_in.process).to be_truthy
        expect(sign_in.user).to eq(user)
        expect(sign_in.user.access_keys.count).to eq(1)
        expect(sign_in.access_key).to be_instance_of(AccessKey)
      end
    end

    context 'with incorrect credentials' do
      let(:with_x_sign_in) do
        described_class.new account_name: 'poskoa',
                            email: 'a@a.com',
                            password: 'x pass'
      end

      it 'rejects user' do
        expect(with_x_sign_in.process).to be_falsey
        expect(with_x_sign_in.errors.size).to eq(1)
        expect(with_x_sign_in.errors.first).to eq('Incorrect credentials')
      end
    end
  end

  describe '#user' do
    before { sign_in.process }
    subject { sign_in.user }

    it { is_expected.to be_present }
  end

  describe '#account' do
    before { sign_in.process }
    subject { sign_in.account }

    it { is_expected.to be_present }
  end
end
