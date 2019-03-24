require 'rails_helper'

RSpec.describe AccountSettingBlueprint, type: :blueprint do
  let(:account_setting) { create(:account_setting) }
  let(:blueprint) { described_class.render_as_hash(account_setting) }
  let(:keys) do
    [:id, :tax_feature, :shifts_feature, :discounts_feature, :account]
  end

  it 'has all the keys' do
    keys.each do |key|
      expect(blueprint).to have_key(key)
    end
  end
end
