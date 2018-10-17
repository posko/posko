require 'rails_helper'

RSpec.describe ProductsHelper, type: :helper do
  describe '#selling_policy_options' do
    include ProductsHelper
    subject { selling_policy_options }

    it { is_expected.to eq([['Each', 'each'], ['Weight', 'weight']]) }
  end
end
