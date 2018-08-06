require 'rails_helper'

RSpec.describe QueryObject do
  let(:account) { create(:account) }
  let(:products) { create_list(:product, 3, account: account) }
  before { products }
  describe 'anonymous class' do
    let(:products_query_class) {
      Class.new(QueryObject) do
        add_range_attributes :created_at
        add_range_attributes :id
        add_searchables :title
        add_searchables :id
      end
    }

    let(:query) { products_query_class.new params, account.products }
    describe '#call' do
      let(:params) do
        {
          ids: [products[0].id, products[1].id],
          id_min: products[1].id
        }
      end

      it "filters query with params" do
        expect(query.call.count).to eq(1)
      end
    end

    context 'using ids' do
      let(:params) { { ids: [products[0].id, products[1].id] } }

      it "filters query" do
        expect(query.call.count).to eq(2)
      end
    end

    context 'using limit' do
      let(:params) { { limit: 2, page: 1} }

      it "filters query" do
        expect(query.call.count).to eq(2)
      end
    end

    context 'with page' do
      context "1" do
        let(:params) { { limit: 2, page: 1} }
        it "returns first page" do
          expect(query.call.count).to eq(2)
        end
      end

      context "1" do
        let(:params) { { limit: 2, page: 2} }
        it "returns first page" do
          expect(query.call.count).to eq(1)
        end
      end
    end

    context "using since_id" do
      let(:params) { { since_id: products[1].id } }
      it "returns list of products" do
        expect(query.call.count).to eq(1)
      end
    end

    context "using attribute_min" do
      it "returns list of products" do
        # TODO: Improve this test
        # there are 3 default products
        Timecop.freeze(Time.current + 1.day)
        product1 = create(:product, account: account)
        Timecop.return
        Timecop.freeze(Time.current + 2.day)
        product2 = create(:product, account: account)
        Timecop.return
        q = products_query_class.new({ created_at_min: product1.created_at }, account.products)
        expect(q.call.count).to eq(2)
      end

      it "returns list of products" do
        # TODO: Improve this test
        # there are 3 default products
        # create products before the the current date
        Timecop.freeze(Time.current - 1.day)
        product1 = create(:product, account: account)
        Timecop.return
        Timecop.freeze(Time.current - 2.day)
        product2 = create(:product, account: account)
        Timecop.return
        q = products_query_class.new({ created_at_max: product1.created_at + 1 }, account.products)
        expect(q.call.count).to eq(2)
      end
    end

    describe "#add_range_attributes" do
      it "adds created_at" do
        expect(products_query_class.range_attributes.count).to eq(2)
      end
    end

    describe "#add_searchables" do
      it "adds created_at" do
        expect(products_query_class.searchables.count).to eq(2)
      end
    end

    describe "#add_searchables" do
      let(:params) { { id: products[0]}}
      it "adds created_at" do
        expect(query.call.count).to eq(1)
      end
    end
  end
end
