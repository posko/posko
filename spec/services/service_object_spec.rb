require 'rails_helper'

RSpec.describe ServiceObject do
  class CustomService < ServiceObject
    def initialize(options={}) end;
    def perform
      @performed = true
    end
  end

  describe "Child class" do

    context ".perform with" do
      it "performs its service" do
        service = CustomService.perform
        expect(service.class).to be(CustomService)
      end
    end

    context ".perform with no #perform definition" do
      class NoPerformService < ServiceObject
        def initialize(options={}) end;
      end
      it "raise and error" do
        expect { NoPerformService.perform }.to raise_exception.with_message("'perform' method Not implemented")
      end
    end
  end
end
