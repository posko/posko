require 'rails_helper'

RSpec.describe ProductsHelper, type: :helper do
  include ProductsHelper
  describe '#selling_policy_options' do
    subject { selling_policy_options }

    it { is_expected.to eq([['Each', 'each'], ['Weight', 'weight']]) }
  end

  describe '#category_options' do
    subject { category_options }

    let(:category) { create(:category) }
    let(:html) do
      directory = category.directory
      id = category.id
      "<option data-directory=\"#{directory}\" value=\"#{id}\">Men</option>"
    end

    before { category }

    it { is_expected.to eq(html) }
  end
end
