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

    before { category }

    it { is_expected.to eq([[category.name, category.id]]) }
  end
end
