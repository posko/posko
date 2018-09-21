require 'rails_helper'

RSpec.describe UserDatatable do
  let(:user_datatable) { described_class.new(double('view', params: params), options) }
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  # supporting data
  let(:params) do
    ActionController::Parameters.new('columns': {})
  end
  let(:options) do
    {
      current_account: account
    }
  end

  before { user }
  describe '#to_json' do
    let(:expected_json) do
      {
        "recordsTotal": 1,
        "data": [{
          email: user.email
        }]
      }
    end

    it { expect(user_datatable.to_json).to include_json(expected_json) }
  end
end
