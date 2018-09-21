require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  let(:user) { create(:user) }
  let(:role) { create(:role, name: 'manager', account: user.account) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end
  describe 'GET #index' do
    it 'assigns @roles' do
      get :index
      expect(assigns(:roles)).to eq([role])
    end
  end
  describe 'GET #new' do
    it 'assigns @role' do
      get :new
      expect(assigns(:role)).to be_a_new_record
    end
  end
  describe 'POST #create' do
    context 'with successful attempt' do
      before { role }
      it 'creates role' do
        params = { role: { name: 'supervisor' } }
        expect { post(:create, params: params) }.to change(Role, :count).by(1)
      end
    end

    context 'with failed attempt' do
      before { role }
      it "renders 'new' template" do
        params = { role: { name: nil } }
        post(:create, params: params)
        expect(response).to render_template 'new'
      end
    end
  end
  describe 'GET #edit' do
    it 'assigns @role' do
      params = { id: role.id }
      get :edit, params: params
      expect(assigns(:role)).to eq(role)
    end
  end
  describe 'PATCH #update' do
    context 'with successful attempt' do
      it 'updates role' do
        params = { id: role.id, role: { name: 'admin' } }
        patch :update, params: params
        expect(assigns(:role).name).to eq('admin')
        expect(response).to redirect_to(roles_path)
      end
    end
    context 'with failed attempt' do
      it "renders 'edit'" do
        params = { id: role.id, role: { name: nil } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end
  describe 'GET #show' do
    it 'updates role' do
      params = { id: role.id }
      patch :show, params: params
      expect(assigns(:role)).to eq(role)
    end
  end
  describe 'DELETE #destroy' do
    it 'updates role' do
      params = { id: role.id }
      delete :destroy, params: params
      expect(assigns(:role)).to eq(role)
    end
    it 'raises an exception' do
      expect { delete :destroy, params: { id: 'nothing' } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
