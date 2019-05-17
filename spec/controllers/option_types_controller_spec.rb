require 'rails_helper'

RSpec.describe OptionTypesController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, account: user.account) }
  let(:option_type) { create(:option_type, product: product) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    before do
      option_type
      get :index, params: { product_id: product.id }
    end

    it { expect(assigns(:option_types)).to eq([option_type]) }
    it { expect(json).to include_json(option_types: []) }
  end

  describe 'POST #create' do
    context 'with passing params' do
      let(:params) { { product_id: product.id, option_type: { name: 'Size' } } }

      before { post(:create, params: params) }

      it { expect(OptionType.count).to eq(1) }
      it { expect(json).to include_json(option_type: {}) }
    end

    context 'with failing params' do
      let(:params) { { product_id: product.id, option_type: { name: nil } } }

      before { post(:create, params: params) }

      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with passing params' do
      let(:params) { { id: option_type.id, option_type: { name: 'admin' } } }

      it { expect(assigns(:option_type).name).to eq('admin') }
      it { expect(json).to include_json(option_type: {}) }
    end

    context 'with failing params' do
      let(:params) { { id: option_type.id, option_type: { name: nil } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: option_type.id } }

    it { expect(assigns(:option_type)).to eq(option_type) }
    it { expect(json).to include_json(option_type: {}) }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: option_type.id } }

      it { expect(assigns(:option_type)).to be_destroyed }
      it { expect(json).to include_json(option_type: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
