require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:product) { create(:product, :with_variant, account: account) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    before do
      product
      get :index
    end

    it { expect(assigns(:products)).to eq([product]) }
    it { expect(json).to include_json(products: []) }
  end

  describe 'POST #create' do
    context 'with successful attempt' do
      let(:params) do
        {
          product: {
            title: 'Bag',
            price: '99.9',
            product_type: 'regular',
            vendor: 'Bag Company'
          }
        }
      end

      before { post(:create, params: params) }

      it 'creates product' do
        expect(account.products.count).to eq(1)
        expect(account.variants.count).to eq(1)
      end
    end

    context 'with failed attempt' do
      let(:params) { { product: { title: nil, price: '99.9' } } }

      before do
        post(:create, params: params)
      end

      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with successful attempt' do
      let(:params) do
        { id: product.id, product: { title: 'High Quality Bag' } }
      end

      it 'updates product' do
        expect(product.reload.title).to eq('High Quality Bag')
        expect(json).to include_json(product: {})
      end
    end

    context 'with failed attempt' do
      let(:params) { { id: product.id, product: { title: nil } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: product.id } }

    it { expect(assigns(:product)).to eq(product) }
    it { expect(json).to include_json(product: {}) }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: product.id } }

      it { expect(assigns(:product)).to be_destroyed }
      it { expect(json).to include_json(product: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
