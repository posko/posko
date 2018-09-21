require 'rails_helper'

RSpec.describe ProductImporter, type: :importer do
  let(:filepath) { 'spec/factories/csv/products.csv' }
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:importer) { ProductImporter.new(filepath: filepath, account_id: account.id, user_id: user.id) }

  describe '#perform' do
    it 'imports product from csv' do
      importer.perform
      expect(Product.count).to eq 2
    end
  end
end
