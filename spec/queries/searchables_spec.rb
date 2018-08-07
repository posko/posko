require 'rails_helper'

RSpec.describe Searchables do
  let(:sample_class) do
    Class.new do
      include Searchables
      attr_accessor :params, :relation
      def initialize(params = {}, relation)
        @relation = relation
        @params = params
      end
      def call
        filter_by_searchables
        relation
      end
      add_searchables :title
    end
  end

  describe 'anonymous class' do
    describe 'subclass' do
      let(:sample_subclass) {
        Class.new(sample_class) do
          add_searchables :name
        end
      }
      let(:query_subclass) { sample_subclass }

      it "has searchables name" do
        expect(query_subclass.searchables.first).to eq(:title)
        expect(query_subclass.searchables.last).to eq(:name)
      end
    end

    describe 'instance' do
      context '#searchables' do
        let(:query_instance) { sample_class.new nil, nil }

        it "has searchables :title" do
          expect(query_instance.searchables.first).to eq(:title)
        end

        it "doesn't override searchables" do
          expect{ query_instance.searchables = [:hello] }.to raise_error(NoMethodError)
        end
      end

      context "#filter_searchable" do
        it "filters attributes" do
          products = create_list(:product, 5, title: "Milk")
          create(:product)
          query = sample_class.new({ title: 'Milk' }, Product.all)

          expect(query.call.count).to eq(5)
        end
      end
    end

    describe 'included' do
      context "with attributeless class" do
        let(:attributeless_class) {
          Class.new do
            include Searchables
          end
        }
        it "is working well" do
          object = attributeless_class.new
          expect(object.searchables).to eq([])
        end
      end
    end
  end
end
