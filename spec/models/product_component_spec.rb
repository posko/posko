require 'rails_helper'

RSpec.describe ProductComponent, type: :model do
  let(:variant) { create(:variant, title: "Main Variant") }
  let(:variant2) { create(:variant, title: "Other Variant") }

  describe "#create" do
    context "regular" do
      let(:product_component) { create(:product_component, variant: variant, parent_variant: variant2) }
      it " adds product with default variant" do
        expect(product_component.title).to eq("Other Variant")
      end
    end
  end
  describe "associations" do
    it { is_expected.to belong_to(:variant) }
  end
end
