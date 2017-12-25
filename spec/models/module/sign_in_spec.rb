require 'rails_helper'

RSpec.describe SignIn do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  describe "Factory" do
    it "loads all the data" do
      expect(user).to be_present
    end
  end
  describe '#process' do
    let(:sign_in) { SignIn.new account_name: account.name, email: user.email, password: user.password }
    it "does its job" do
      expect(sign_in.process).to be_truthy
      expect(sign_in.user).to eq(user)

    end
  end

  describe '#user' do
  end

  describe '#account' do
  end

end
