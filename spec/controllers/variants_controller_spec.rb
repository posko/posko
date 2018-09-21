require 'rails_helper'

RSpec.describe VariantsController, type: :controller do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:product) { create(:product, account: account) }
  let(:variant) { create(:variant, product: product) }
  let(:valid_variant_param) do
    { title: 'Red Bag',
      price: '99.9',
      variant_type: 'regular',
      vendor: 'Bag Company' }
  end

  before { sign_in }
  describe 'GET #index' do
    it 'assigns @variants' do
      get :index, params: { product_id: product.id }
      expect(assigns(:variants)).to eq([variant])
    end
  end
  describe 'GET #new' do
    it 'assigns @variant' do
      get :new, params: { product_id: product.id }
      expect(assigns(:variant)).to be_a_new_record
    end
  end
  describe 'POST #create' do
    context 'with successful attempt' do
      let(:params) { { variant: valid_variant_param, product_id: product.id } }

      before { post(:create, params: params) }
      it 'creates variant' do
        expect(account.variants.count).to eq(1)
      end
    end

    context 'with failed attempt' do
      before { variant }
      it "renders 'new' template" do
        params = { variant: { title: nil, price: '99.9' },
                   product_id: product.id }
        post(:create, params: params)
        expect(response).to render_template 'new'
      end
    end
  end
  describe 'GET #edit' do
    it 'assigns @variant' do
      params = { id: variant.id }
      get :edit, params: params
      expect(assigns(:variant)).to eq(variant)
    end
  end
  describe 'PATCH #update' do
    context 'with successful attempt' do
      it 'updates variant' do
        params = { id: variant.id, variant: { title: 'High Quality Bag' } }
        patch :update, params: params
        expect(assigns(:variant).title).to eq('High Quality Bag')
        expect(response).to redirect_to(product_variants_path(product.id))
      end
    end
    context 'with failed attempt' do
      it "renders 'edit'" do
        params = { id: variant.id, variant: { title: nil } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end
  describe 'GET #show' do
    it 'updates variant' do
      params = { id: variant.id }
      patch :show, params: params
      expect(assigns(:variant)).to eq(variant)
    end
  end
  describe 'DELETE #destroy' do
    it 'updates variant' do
      params = { id: variant.id }
      delete :destroy, params: params
      expect(assigns(:variant)).to eq(variant)
      expect(assigns(:variant)).to be_deleted_status
    end
    it 'raises an exception' do
      expect do
        delete :destroy, params: { id: 'nothing' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
