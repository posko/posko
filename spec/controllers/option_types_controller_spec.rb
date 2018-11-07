require 'rails_helper'

RSpec.describe OptionTypesController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, account: user.account) }
  let(:option_type) { create(:option_type, product: product) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end

  describe 'GET #index' do
    before { product }

    it 'assigns @option_types' do
      get :index, params: { product_id: product.id }
      expect(assigns(:option_types)).to eq([option_type])
    end
  end

  describe 'GET #new' do
    it 'assigns @option_type' do
      get :new, params: { product_id: product.id }
      expect(assigns(:option_type)).to be_a_new_record
    end
  end

  describe 'POST #create' do
    context 'with successful attempt' do
      before { option_type }

      it 'creates option_type' do
        params = { product_id: product.id, option_type: { name: 'Size' } }
        expect do
          post(:create, params: params)
        end.to change(OptionType, :count).by(1)
      end
    end

    # context 'with failed attempt' do
    #   before { option_type }
    #   it "renders 'new' template" do
    #     params = { option_type: { id: nil } }
    #     post(:create, params: params)
    #     expect(response).to render_template "new"
    #   end
    # end
  end

  describe 'GET #edit' do
    it 'assigns @option_type' do
      params = { id: option_type.id }
      get :edit, params: params
      expect(assigns(:option_type)).to eq(option_type)
    end
  end

  describe 'PATCH #update' do
    context 'with successful attempt' do
      it 'updates option_type' do
        params = { id: option_type.id, option_type: { name: 'admin' } }
        patch :update, params: params
        expect(assigns(:option_type).name).to eq('admin')
        expect(response).to redirect_to(option_type_path(option_type))
      end
    end

    context 'with failed attempt' do
      it "renders 'edit'" do
        params = { id: option_type.id, option_type: { name: nil } }
        patch :update, params: params
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'GET #show' do
    it 'updates option_type' do
      params = { id: option_type.id }
      patch :show, params: params
      expect(assigns(:option_type)).to eq(option_type)
    end
  end

  describe 'DELETE #destroy' do
    it 'updates option_type' do
      params = { id: option_type.id }
      delete :destroy, params: params
      expect(assigns(:option_type)).to eq(option_type)
    end
    it 'raises an exception' do
      expect do
        delete :destroy, params: { id: 'nothing' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
