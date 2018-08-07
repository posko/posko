require 'rails_helper'

RSpec.describe RangeAttributes do
  let(:query_object_class) do
    Class.new do
      include RangeAttributes
      attr_accessor :params, :relation
      def initialize(params = {}, relation)
        @relation = relation
        @params = params
      end
      def call
        filter_by_range_attributes
        relation
      end
      add_range_attributes :id
    end
  end

  describe 'anonymous class' do
    describe 'subclass' do
      let(:query_object_subclass) {
        Class.new(query_object_class) do
          add_range_attributes :subclass_id
        end
      }
      let(:query_subclass) { query_object_subclass }
      it "has range attributes :id" do
        expect(query_subclass.range_attributes.first).to eq(:id)
        expect(query_subclass.range_attributes.last).to eq(:subclass_id)
      end
    end
    describe 'instance' do
      context '#range_attribute' do
        let(:query_instance) { query_object_class.new nil, nil}
        it "has range attributes :id" do
          expect(query_instance.range_attributes.first).to eq(:id)
        end

        it "doesn't override range_attributes" do
          expect{ query_instance.range_attributes = [:hello] }.to raise_error(NoMethodError)
        end
      end

      context '#filter_range_attributes' do
        it "filters attributes" do
          products = create_list(:product, 5)
          query = query_object_class.new({ id_min: products[3] }, Product.all)
          expect(query.call.count).to eq(2)
        end
        context "using min and max" do
          it "filters attributes" do
            products = create_list(:product, 5)
            query = query_object_class.new({ id_max: products[1]}, Product.all)
            expect(query.call.count).to eq(2)
          end
        end
      end
    end
  end
end
