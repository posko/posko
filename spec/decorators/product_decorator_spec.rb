require 'rails_helper'

RSpec.describe ProductDecorator, type: :decorator do
  let(:product) { create(:product, title: 'Bag') }

  describe '#title_link' do
    let(:title_link) { product.decorate.title_link }

    it {
      expect(title_link).to eq(
        "<a href=\"/products/#{product.id}\">Bag</a>"
      )
    }
  end
end
