require 'rails_helper'

RSpec.describe AccountBlueprint, type: :blueprint do
  let(:account) { create(:account) }
  let(:blueprint) { described_class.render_as_hash(account) }
  let(:keys) do
    [:id, :name, :company, :account_status, :account_type, :status]
  end

  it 'has all the keys' do
    keys.each do |key|
      expect(blueprint).to have_key(key)
    end
  end
end
