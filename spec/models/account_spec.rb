require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { create(:account, name: "first_company", company: "First Company") }
  describe "Account creation" do
    it "creates new account" do
      account = Account.create name: "first_company", company: "First Company"
      expect(account).to be_truthy
    end
  end

end
