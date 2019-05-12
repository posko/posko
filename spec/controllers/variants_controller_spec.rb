require 'rails_helper'

RSpec.describe VariantsController, type: :controller do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:product) { create(:product, account: account) }
  let(:variant) { create(:variant, product: product) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    before { get :index, params: { product_id: product.id } }

    it { expect(assigns(:variants).count).to eq(1) }
  end

  describe 'POST #create' do
    context 'with successful attempt' do
      let(:params) do
        {
          variant: {
            title: 'Red Bag',
            price: '99.9',
            variant_type: 'regular',
            vendor: 'Bag Company'
          },
          product_id: product.id
        }
      end

      before { post(:create, params: params) }

      it { expect(account.variants.count).to eq(2) }
      it { expect(json).to include_json(variant: {}) }
    end

    context 'with failed attempt' do
      let(:params) do
        {
          variant: { price: nil },
          product_id: product.id
        }
      end

      before { post(:create, params: params) }

      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with successful attempt' do
      let(:params) { { id: variant.id, variant: { price: 100 } } }

      it { expect(json).to include_json(variant: { price: '100.0' }) }
    end

    context 'with failed attempt' do
      let(:params) { { id: variant.id, variant: { price: nil } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: variant.id } }

    it { expect(assigns(:variant)).to eq(variant) }
    it { expect(json).to include_json(variant: {}) }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: variant.id } }

      it { expect(assigns(:variant)).to be_destroyed }
      it { expect(json).to include_json(variant: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
