require 'rails_helper'

RSpec.describe CustomerBlueprint, type: :blueprint do
  let(:customer) { create(:customer) }
  let(:blueprint) { described_class.render_as_hash(customer) }
  let(:keys) do
    [:id, :default_address, :first_name, :middle_name, :last_name, :email,
     :suffix, :note, :customer_type, :customer_status, :status]
  end

  it 'has all the keys' do
    keys.each do |key|
      expect(blueprint).to have_key(key)
    end
  end
end
