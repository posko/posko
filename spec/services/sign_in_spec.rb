require 'rails_helper'

RSpec.describe SignIn do
  let(:account) { create(:account, name: "posko") }
  let(:user) { create(:user, email: "a@a.com", password: "pass", account: account) }
  let(:sign_in) { user; SignIn.new account_name: "posko", email: "a@a.com", password: "pass" }
  describe "Factory" do
    it "creates necessary data" do
      expect(user).to be_present
      expect(user.email).to eq("a@a.com")
      expect(User.count).to eq(1)
      expect(Account.count).to eq(1)
    end
  end
  describe '#process' do
    context "with correct credentials" do
      it "accepts user" do
        expect(sign_in).to be_valid
        expect(sign_in.errors.count).to eq(0)
        expect(sign_in.process).to be_truthy
        expect(sign_in.user).to eq(user)
      end
    end
    context "with incorrect credentials" do
      let(:with_x_sign_in) { user; SignIn.new account_name: "poskoa", email: "a@a.com", password: "x pass" }
      it "rejects user" do
        expect(with_x_sign_in).to be_invalid
        expect(with_x_sign_in.process).to be_falsey
        expect(with_x_sign_in.errors.size).to eq(1)
        expect(with_x_sign_in.errors.full_messages.first).to eq("Incorrect credentials")
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
