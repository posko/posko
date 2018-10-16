require 'rails_helper'

RSpec.describe ProductCreationService do
  let(:user) { create(:user) }
  let(:account) { user.account }

  describe '#perform' do
    let(:params) do
      {
        account: account,
        created_by: user,
        title: 'bag',
        vendor: 'hawk',
        price: 100,
        cost: 65,
        compare_at_price: 140,
        sku: '111000'
      }
    end

    context 'with correct params' do
      it 'creates an invoice' do
        service = described_class.new(params)
        expect(service).to be_valid
        expect(service.perform).to be_truthy
        expect(Product.count).to eq(1)
        expect(Variant.count).to eq(1)
      end
    end

    # TODO: this chunk doesn't do anything yet
    # context "faulty params" do
    #   let(:invoice_number) { nil }
    #   it "returns false" do
    #     service = InvoiceCreationService.perform(params)
    #     expect(service.valid?).to be_falsey
    #   end
    # end
  end
end
