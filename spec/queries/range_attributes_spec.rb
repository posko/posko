require 'rails_helper'

RSpec.describe RangeAttributes do
  let(:query_object_class) {
    Class.new do
      include RangeAttributes
      # class_attribute :range_attributes
      add_range_attributes :id
      # def self.add_range_attribute
      #   range_attributes = []
      # end
    end
  }
  describe 'anonymous class' do

    describe 'main class' do
      it "has range attributes :id" do
        expect(query_object_class.range_attributes.first).to eq(:id)
      end
    end
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
      let(:query_instance) { query_object_class.new }
      it "has range attributes :id" do
        expect(query_instance.range_attributes.first).to eq(:id)
      end

      it "doesn't override range_attributes" do
        expect{ query_instance.range_attributes = [:hello] }.to raise_error(NoMethodError)
      end
    end

  end

end
