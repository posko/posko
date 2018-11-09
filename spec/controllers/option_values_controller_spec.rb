require 'rails_helper'

RSpec.describe OptionValuesController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, account: user.account) }
  let(:option_type) { create(:option_type, product: product) }
  let(:option_value) { create(:option_value, option_type: option_type) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end

  describe 'GET #index' do
    it 'assigns @option_values' do
      get :index, params: { option_type_id: option_type.id }
      expect(assigns(:option_values)).to eq([option_value])
    end
  end

  describe 'GET #new' do
    it 'assigns @option_value' do
      get :new, params: { option_type_id: option_type.id }
      expect(assigns(:option_value)).to be_a_new_record
    end
  end

  describe 'POST #create' do
    context 'with successful attempt' do
      let(:params) do
        {
          option_type_id: option_type.id,
          option_value: { name: 'medium' }
        }
      end

      before { option_value }

      it 'creates option_value' do
        expect do
          post(:create, params: params)
        end.to change(OptionValue, :count).by(1)
      end
    end

    # context 'with failed attempt' do
    #   before { option_value }
    #   it "renders 'new' template" do
    #     params = { option_value: { id: nil } }
    #     post(:create, params: params)
    #     expect(response).to render_template "new"
    #   end
    # end
  end

  describe 'GET #edit' do
    it 'assigns @option_value' do
      params = { id: option_value.id }
      get :edit, params: params
      expect(assigns(:option_value)).to eq(option_value)
    end
  end

  describe 'PATCH #update' do
    context 'with successful attempt' do
      it 'updates option_value' do
        params = { id: option_value.id, option_value: { name: 'admin' } }
        patch :update, params: params
        expect(assigns(:option_value).name).to eq('admin')
        expect(response).to redirect_to(option_value)
      end
    end

    context 'with failed attempt' do
      it "renders 'edit'" do
        params = { id: option_value.id, option_value: { name: '' } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'GET #show' do
    it 'updates option_value' do
      params = { id: option_value.id }
      patch :show, params: params
      expect(assigns(:option_value)).to eq(option_value)
    end
  end

  describe 'DELETE #destroy' do
    it 'updates option_value' do
      params = { id: option_value.id }
      delete :destroy, params: params
      expect(assigns(:option_value)).to eq(option_value)
    end
    it 'raises an exception' do
      expect do
        delete :destroy, params: { id: 'nothing' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
