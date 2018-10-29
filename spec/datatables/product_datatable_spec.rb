require 'rails_helper'

RSpec.describe ProductDatatable, type: :datatable do
  let(:product_datatable) { described_class.new(view, options) }

  let(:account) { create(:account) }
  let(:product) { create(:product, account: account) }

  # supporting data
  let(:view) do
    params = ActionController::Parameters.new('columns': {})
    view_double = instance_double('view', params: params)
    view_double.extend ActiveSupport::NumberHelper
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
