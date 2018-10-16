# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountSetting, type: :model do
  let(:account_setting) { create(:account_setting) }

  describe 'Factory data creation' do
    it 'creates data based on factory file' do
      expect(account_setting).to be_present
      expect(account_setting).to be_persisted
    end
  end

  describe 'Activerecord associations' do
    it { expect(account_setting).to belong_to(:account) }
  end

  describe 'Activerecord validations' do
    it { expect(account_setting).to validate_presence_of(:account) }
  end
end
