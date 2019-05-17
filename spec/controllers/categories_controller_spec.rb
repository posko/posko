require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category, account: user.account) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'GET #index' do
    before do
      category
      get :index
    end

    it { expect(assigns(:categories)).to eq([category]) }
    it { expect(json).to include_json(categories: []) }
  end

  describe 'POST #create' do
    before { post(:create, params: params) }

    context 'with passing params' do
      let(:params) { { category: { name: 'juice' } } }

      it { expect(Category.count).to eq(1) }
      it { expect(json).to include_json(category: {}) }
    end

    context 'with failing params' do
      let(:params) { { category: { name: nil } } }

      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with passing params' do
      let(:params) { { id: category.id, category: { name: 'juice' } } }

      it { expect(assigns(:category).name).to eq('juice') }
      it { expect(json).to include_json(category: {}) }
    end

    context 'with failing params' do
      let(:params) { { id: category.id, category: { name: nil } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: category.id } }

    it { expect(assigns(:category)).to eq(category) }
    it { expect(json).to include_json(category: {}) }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: category.id } }

      it { expect(assigns(:category)).to be_destroyed }
      it { expect(json).to include_json(category: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
