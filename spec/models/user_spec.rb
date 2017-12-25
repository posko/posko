require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, password: "mypassword") }
  context ".authenticate" do
    it "authenticates correct password" do
      result = user.authenticate "mypassword"
      expect(result).to be_truthy
    end
    it "rejects incorrect password" do
      result = user.authenticate "wrongpassword"
    end
  end
end
