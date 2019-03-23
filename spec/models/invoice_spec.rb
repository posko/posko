require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:product) { create(:product) }
  let(:variant) { product.variants.create(price: 100, title: 'Large') }
  let(:customer) { create(:customer) }
  let(:invoice) do
    create(:invoice,
      customer: customer,
      account: customer.account)
  end

  describe '#create' do
    before { invoice }

    it 'creates new invoice ' do
      expect(customer.invoices.count).to eq(1)
    end
  end

  describe 'validations' do
    subject { invoice }

    it { is_expected.to validate_presence_of(:invoice_number) }
    it { is_expected.to validate_presence_of(:total_line_items_price) }
    it { is_expected.to validate_presence_of(:total_discounts) }
    it { is_expected.to validate_presence_of(:subtotal) }
    it { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_presence_of(:total_tax) }
    it { is_expected.to validate_presence_of(:total_weight) }
  end

  describe 'associations' do
    it { expect(invoice).to belong_to(:user) }
    it { expect(invoice).to belong_to(:account) }
    it { expect(invoice).to belong_to(:customer).optional }
    it { expect(invoice).to belong_to(:shift).optional }
    # it { expect(user).to have_many(:variants) }
  end
  # describe '#recompute_values' do
  #   it "recomputes values and save itself" do
  #    invoice.invoice_lines.create(product: product,
  #                                 variant: variant,
  #                                 price: 100,
  #                                 title: 'Large')
  #     invoice.recompute_values
  #     expect(invoice.total_line_items_price).to eq(100)
  #     invoice.invoice_lines.create(product: product,
  #                                 variant: variant,
  #                                 price: 50,
  #                                 title: "small")
  #     invoice.recompute_values
  #     expect(invoice.total_line_items_price).to eq(150)
  #   end
  # end
  # describe "#recompute callback" do
  #   subject { create(:invoice) }

  it do
    expect(invoice).to callback(:pass_validations).before(:validation)
                                                  .on(:create)
  end
  # end
end
