require 'rails_helper'

RSpec.describe Searchables do
  let(:sample_class) {
    Class.new do
      include Searchables
      add_searchables :id
    end
  }
  describe 'anonymous class' do
    describe 'main class' do
      it "has searchables :id" do
        expect(sample_class.searchables.first).to eq(:id)
      end
    end
    describe 'subclass' do
      let(:sample_subclass) {
        Class.new(sample_class) do
          add_searchables :name
        end
      }
      let(:query_subclass) { sample_subclass }
      it "has searchables name" do
        expect(query_subclass.searchables.first).to eq(:id)
        expect(query_subclass.searchables.last).to eq(:name)
      end
    end
    describe 'instance' do
      let(:query_instance) { sample_class.new }
      it "has searchables :id" do
        expect(query_instance.searchables.first).to eq(:id)
      end

      it "doesn't override searchables" do
        expect{ query_instance.searchables = [:hello] }.to raise_error(NoMethodError)
      end
    end

  end

end
