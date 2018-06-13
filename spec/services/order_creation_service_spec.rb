require 'rails_helper'

RSpec.describe OrderCreationService do
  let(:user) { create(:user) }
  let(:account)  {user.account }
  let(:product) { create(:product, account: account) }
  let(:variant) { product.variants.create(price: 100, title: "Large") }
  let(:customer) { create(:customer, account: account) }
  describe '#perform' do
    let(:params) do
      {
        order: {
          customer_id: customer_id,
          order_number: "1232"
        },
        order_lines: [
          {
            variant_id: variant.id,
            product_id: product.id,
            price: 101,
            title: variant.title
          },
          {
            variant_id: variant.id,
            product_id: product.id,
            price: 101,
            title: variant.title
          }
        ]
      }
    end

    context "correct params" do
      let(:customer_id) { customer.id }
      it "creates an order" do
        service = OrderCreationService.perform(user: user, params: params)
        order = service.order
        expect(service).to be_truthy
        expect(service).to be_performed
        expect(account.order_lines.count).to be(2)
        expect(order.total_line_items_price).to eq(202)
      end
    end
    context "faulty params" do
      let(:customer_id) { nil }
      it "returns false" do
        service = OrderCreationService.perform(user: user, params: params)
        expect(service.valid?).to be_falsey
      end
    end
  end

end
