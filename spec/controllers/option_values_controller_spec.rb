require 'rails_helper'

RSpec.describe OptionValuesController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, account: user.account) }
  let(:option_type) { create(:option_type, product: product) }
  let(:option_value) { create(:option_value, option_type: option_type) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    let(:params) { { option_type_id: option_type.id } }

    before do
      option_value
      get :index, params: params
    end

    it { expect(assigns(:option_values)).to eq([option_value]) }
    it { expect(json).to include_json(option_values: []) }
  end

  describe 'POST #create' do
    context 'with successful attempt' do
      let(:params) do
        {
          option_type_id: option_type.id,
          option_value: { name: 'medium' }
        }
      end

      before { post(:create, params: params) }

      it { expect(OptionValue.count).to eq(1) }
      it { expect(json).to include_json(option_value: {}) }
    end

    context 'with failed attempt' do
      let(:params) do
        {
          option_type_id: option_type.id,
          option_value: { name: nil }
        }
      end

      before { post(:create, params: params) }

      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with passing params' do
      let(:params) { { id: option_value.id, option_value: { name: 'red' } } }

      it { expect(assigns(:option_value).name).to eq('red') }
      it { expect(json).to include_json(option_value: {}) }
    end

    context 'with failed attempt' do
      let(:params) { { id: option_value.id, option_value: { name: '' } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: option_value.id } }

    it { expect(assigns(:option_value)).to eq(option_value) }
    it { expect(json).to include_json(option_value: {}) }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: option_value.id } }

      it { expect(assigns(:option_value)).to be_destroyed }
      it { expect(json).to include_json(option_value: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
