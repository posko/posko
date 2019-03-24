require 'rails_helper'

RSpec.describe AccessKeyBlueprint, type: :blueprint do
  let(:access_key) { create(:access_key) }
  let(:blueprint) { described_class.render_as_hash(access_key) }
  let(:keys) do
    [:id, :token, :auth_token]
  end

  it 'has all the keys' do
    keys.each do |key|
      expect(blueprint).to have_key(key)
    end
  end
end
