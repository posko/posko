require 'rails_helper'

RSpec.describe SignInForm do
  let(:account) { create(:account, name: "posko") }
  let(:user) { create(:user, email: "a@a.com", password: "pass", account: account, access_key_count: 0) }
  let(:sign_in_form) do
    SignInForm.new(
      account_name: "posko",
      email: "a@a.com",
      password: password
    )
  end

  # supporting data
  let(:password) { "pass"}
  before { user }
  describe '#save' do
    context "with correct credentials" do
      it { expect(sign_in_form.save).to be_truthy }
      it 'creates new access key' do
        sign_in_form.save
        expect(user.access_keys.count).to be 1
      end
    end

    context "with incorrect credentials" do
      let(:password) { "wrong password" }
      before { sign_in_form.save }
      it { expect(user.access_keys.count).to be 0 }
      it { expect(sign_in_form.errors.count).to be 1 }
    end
  end

end
