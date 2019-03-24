require 'rails_helper'

RSpec.describe AddressBlueprint, type: :blueprint do
  let(:address) { create(:address) }
  let(:blueprint) { described_class.render_as_hash(address) }
  let(:keys) do
    [:id, :customer, :address1, :address2, :city, :country_name,
     :country_code, :company, :first_name, :last_name, :middle_name,
     :suffix, :phone, :province, :zip, :default, :address_status, :status]
  end

  it 'has all the keys' do
    keys.each do |key|
      expect(blueprint).to have_key(key)
    end
  end
end
