require 'rails_helper'

RSpec.describe SignUp do
  let(:sign_up){
    SignUp.new account_name: "newcompany", company: "New Company",email: "ceo@new_company.com", password: "mypassword",
      first_name: "Juan", last_name: "Dela Cruz"
  }
  let(:duplicate_account){
    SignUp.new account_name: "newcompany", company: "New Company",email: "ceo@new_company.com", password: "mypassword",
      first_name: "Juan", last_name: "Dela Cruz"
  }
  describe '#process' do
    it "creates a new account and user" do
      # maybe I should store record counts before processing in case of leakage
      expect(sign_up).to be_valid
      expect(sign_up.process).to be_truthy
      expect(Account.count).to eq(1)
      expect(Account.first.users.count).to eq(1)
    end
    it "rejects a invalid credential" do
      # maybe I should store record counts before processing in case of leakage
      expect(sign_up.process).to be_truthy
      expect(duplicate_account.process).to be_falsey
    end
  end

  describe '#user' do
    # let(:sign_up){ SignUp.new account_name: "newcompany", company: "New Company",email: "ceo@new_company.com", password: "mypassword" }
    before do
      sign_up.process
    end
    subject { sign_up.user }
    it{is_expected.to be_truthy}
  end
  describe '#account' do
    subject { -> { sign_up.account } }
    context "when processed" do
      before { sign_up.process }
      it { is_expected.to be_truthy }
    end
    # context "when not yet processed" do
    #   it { is_expected.to raise_error("Account is still empty. Ensure success of 'process' method first.") }
    # end
  end

  describe '#processed?' do
    # let(:sign_up){ SignUp.new account_name: "newcompany", company: "New Company",email: "ceo@new_company.com", password: "mypassword" }
    subject { sign_up.processed? }
    context "when processed" do
      before { sign_up.process }
      it { is_expected.to be_truthy }
    end
    context "when not yet processed" do
      it { is_expected.to be_falsey }
    end
  end
end
