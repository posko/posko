require 'rails_helper'

RSpec.describe ActiveRecordLike, :type => :service do
  describe '#save' do
    class TestRecord < ActiveRecordLike
      attribute :name, String
      validates_presence_of :name
      def persist!
      end
    end
    context "with a validation error" do
      it "" do
        test = TestRecord.new
        expect(test.save).to be_falsey
      end
    end
  end

  describe '#persist!' do
    class EmptyRecord < ActiveRecordLike
    end
    context "unimplemented persist method" do
      it "raises and error" do
        test = EmptyRecord.new
        expect { test.save }.to raise_exception.with_message("persist! method Not implemented")
      end
    end
  end

  describe '#persisted?' do
  end

  describe '#errors_messages' do
  end

  describe '#add_error message' do
  end

  describe '#append_errors obj' do
  end

  describe '#validate_data' do
  end
end
