# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountSetting, type: :model do
  let(:account_setting) { create(:account_setting) }

  describe 'Factory data creation' do
    subject { account_setting }

    it 'creates data based on factory file' do
      is_expected.to be_present
      is_expected.to be_persisted
    end
  end

  describe 'Activerecord associations' do
    subject { account_setting }

    it { is_expected.to belong_to(:account) }
  end

  describe 'Activerecord validations' do
    subject { account_setting }

    it { is_expected.to validate_presence_of(:account) }
  end
end
