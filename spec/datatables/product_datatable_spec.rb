require 'rails_helper'

RSpec.describe ProductDatatable, type: :datatable do
  let(:product_datatable) do
    described_class.new(instance_double('view', params: params),
      options)
  end
  let(:account) { create(:account) }
  let(:product) { create(:product, account: account) }
  # supporting data
  let(:params) do
    ActionController::Parameters.new('columns': {})
  end
  let(:options) do
    {
      current_account: account
    }
  end

  before { product }

  describe '#to_json' do
    let(:expected_json) do
      {
        "recordsTotal": 1,
        "data": [{
          title: product.decorate.title_link,
          status: 'Active'
        }]
      }
    end

    it { expect(product_datatable.to_json).to include_json(expected_json) }
  end
end
