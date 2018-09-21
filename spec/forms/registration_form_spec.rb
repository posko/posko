require 'rails_helper'

RSpec.describe RegistrationForm do
  let(:registration_form) do
    described_class.new(
      account_name: 'newcompany',
      company: 'New Company',
      email: 'ceo@new_company.com',
      password: 'mypassword',
      first_name: 'Juan',
      last_name: 'Dela Cruz'
    )
  end

  describe '#save' do
    it { expect(registration_form).to be_valid }
    context 'with correct input' do
      before { registration_form.save }
      it 'creates a new account with user' do
        expect(User.count).to be 1
        expect(Account.count).to be 1
      end
    end

    context 'with incorrect input' do
      let(:registration_form) { described_class.new }

      it { expect(registration_form).to be_invalid }
    end
  end
end
