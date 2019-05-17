require 'rails_helper'

RSpec.describe ComponentsController, type: :controller do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:product) { create(:product, account: account) }
  let(:variant) { create(:variant, product: product) }
  let(:component) { create(:component, variant: variant) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    before do
      component
      get :index, params: { variant_id: variant.id }
    end

    it { expect(assigns(:components)).to eq([component]) }
    it { expect(json).to include_json(components: []) }
  end

  describe 'POST #create' do
    context 'with passing params' do
      let(:params) do
        {
          component: { quantity: 1, cost: 99.9 },
          variant_id: variant.id
        }
      end

      before { post(:create, params: params) }

      it { expect(Component.count).to eq(1) }
      it { expect(json).to include_json(component: {}) }
    end

    context 'with failing params' do
      let(:params) do
        {
          component: { quantity: nil, cost: 99 },
          variant_id: variant.id
        }
      end

      before { post(:create, params: params) }

      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with passing params' do
      let(:params) do
        { id: component.id, component: { quantity: 2, cost: 99 } }
      end

      it { expect(json).to include_json(component: { quantity: '2.0' }) }
    end

    context 'with failing params' do
      let(:params) { { id: component.id, component: { quantity: nil } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: component.id } }

    it { expect(assigns(:component)).to eq(component) }
    it { expect(json).to include_json(component: {}) }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: component.id } }

      it { expect(assigns(:component)).to be_destroyed }
      it { expect(json).to include_json(component: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
