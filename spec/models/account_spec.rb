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
# it "creates new account with 1 user and 1 branch" do
# 		expect(account).to be_present
# 		expect(Account.count).to eq(1)
# 		# expect(account.users.count).to eq(1)
# 		# expect(account.branches.count).to eq(1)
# 		# expect(account.users.first.branch_id).to eq(account.branches.first.id)
# 	end
# 	context "validations" do
# 		it { is_expected.to validate_presence_of(:name)}
# 		it { is_expected.to validate_presence_of(:company)}
# 		# Format
# 		it { is_expected.to allow_value("valid_account_name").for(:name)}
# 		it { is_expected.not_to allow_value("not a valid name").for(:name)}
# 	end
# 	context "associations" do
#     it { is_expected.to have_many(:users) }
# 		it { is_expected.to have_many(:vehicles) }
# 		it { is_expected.to have_many(:branches) }
# 		it { is_expected.to have_many(:way_bills) }
# 		it { is_expected.to have_many(:control_forms) }
# 		it { is_expected.to have_many(:packages).through(:way_bills) }
# 		it { is_expected.to have_many(:trip_tickets) }
# 		it { is_expected.to have_many(:manifests) }
# 		it { is_expected.to have_many(:rates) }
# 		it { is_expected.to have_many(:roles) }
# 		it { is_expected.to have_many(:branch_rates).through(:rates) }
# 	end
# 	# context "callbacks" do
# 	# 	let(:account) { create :account }
# 	# 	it { expect(account).to callback(:create_main_branch).after(:create) }
# 	# end
#
# 	describe "Class Methods" do
# 		context ".authenticate" do
# 			# let(:user_attr) { attributes_for(:user) }
# 			# let(:account) { create(:account, name: "newcompany", users_attributes: [{ email: "user@newcompany.com", password: "correct1"}]) }
# 			let(:account) { create(:account, name: "newcompany") }
# 			let(:user) { create(:user, account: account, email: "user@newcompany.com", password: "correct1") }
# 			before { user }
# 			it "accepts correct credentials" do
# 				expect(Account.authenticate("newcompany", "user@newcompany.com", "correct1" )).to eq(user)
# 			end
# 			it "denies wrong credentials" do
# 				expect(Account.authenticate("newcompany", "user@newcompany.com", "wrong1" )).to_not eq(user)
# 			end
# 		end
# 	end
