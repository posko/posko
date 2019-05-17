require 'rails_helper'

RSpec.describe SubcategoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category, account: user.account) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'POST #create' do
    context 'with passing params' do
      before { category }

      it 'creates category' do
        params = {
          category_id: category.id,
          category: { name: 'juice' }
        }
        expect do
          post(:create, params: params)
        end.to change(Category, :count).by(1)
      end
    end

    context 'with failing params' do
      before { category }

      it "renders 'new' template" do
        params = {
          category_id: category.id,
          category: { name: nil }
        }

        post(:create, params: params)
        expect(response).to render_template 'new'
      end
    end
  end

  # describe 'GET #edit' do
  #   it 'assigns @category' do
  #     params = { id: category.id, category: { name: 'juice'} }
  #     get :edit, params: params
  #     expect(assigns(:category).reload.name).to eq('juice')
  #   end
  # end
  #
  # describe 'PATCH #update' do
  #   context 'with passing params' do
  #     it 'updates category' do
  #       params = { id: category.id, category: { name: 'juice' } }
  #       patch :update, params: params
  #       expect(assigns(:category).name).to eq('juice')
  #       expect(response).to redirect_to(categories_path)
  #     end
  #   end
  #
  #   context 'with failing params' do
  #     it "renders 'edit'" do
  #       params = { id: category.id, category: { name: nil } }
  #       patch :update, params: params
  #       expect(response).to render_template('edit')
  #     end
  #   end
  # end
  #
  # describe 'GET #show' do
  #   it 'updates category' do
  #     params = { id: category.id }
  #     patch :show, params: params
  #     expect(assigns(:category)).to eq(category)
  #   end
  # end
  #
  # describe 'DELETE #destroy' do
  #   it 'updates category' do
  #     params = { id: category.id }
  #     delete :destroy, params: params
  #     expect(assigns(:category)).to eq(category)
  #   end
  #   it 'raises an exception' do
  #     expect do
  #       delete :destroy, params: { id: 'nothing' }
  #     end.to raise_error(ActiveRecord::RecordNotFound)
  #   end
  # end
end
