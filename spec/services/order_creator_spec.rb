require 'rails_helper'

RSpec.describe OrderCreator, :type => :service do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:customer) { create(:customer, account: account) }
  let(:variant) { create(:variant) }
  let(:variant2) { create(:variant) }
  let(:params) do
    {
      account: account,
      customer: customer,
      user: user,
      order_number: 1,
      order_lines: [
        {
          variant_id: variant.id,
          product_id: variant.product.id,
          quantity: 2
        },
        {
          variant_id: variant2.id,
          product_id: variant2.product.id,
          quantity: 1
        }
      ]
    }
  end
  describe '#process' do
    let(:order_creator) { OrderCreator.new params}
    it "creates an order" do
      order_creator.process
      expect(account.orders.count).to eq(1)
      expect(customer.count).to eq(1)
    end
  end

end
