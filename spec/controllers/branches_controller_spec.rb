## These codes were commented since it doesn't work yet

# require 'rails_helper'
#
# RSpec.describe BranchesController, type: :controller do
#   let(:user) { create(:user) }
#   let(:branch) { create(:branch) }
#
#   before do
#     allow(controller).to receive(:current_user).and_return(user)
#     allow(controller).to receive(:current_account).and_return(user.account)
#   end
#
#   describe 'GET #index' do
#     it 'assigns @branches' do
#       get :index
#       expect(assigns(:branches)).to eq([branch])
#     end
#   end
#
#   describe 'GET #new' do
#     it 'assigns @branch' do
#       get :new
#       expect(assigns(:branch)).to be_a_new_record
#     end
#   end
#
#   describe 'POST #create' do
#     context 'with passing params' do
#       before { branch }
#
#       it 'creates branch' do
#         params = { branch: {} }
#         expect do
#           post(:create, params: params)
#         end.to change(Branch, :count).by(1)
#       end
#     end
#
#     # context 'with failing params' do
#     #   before { branch }
#     #   it "renders 'new' template" do
#     #     params = { branch: { id: nil } }
#     #     post(:create, params: params)
#     #     expect(response).to render_template "new"
#     #   end
#     # end
#   end
#
#   describe 'GET #edit' do
#     it 'assigns @branch' do
#       params = { id: branch.id }
#       get :edit, params: params
#       expect(assigns(:branch)).to eq(branch)
#     end
#   end
#
#   describe 'PATCH #update' do
#     context 'with passing params' do
#       it 'updates branch' do
#         params = { id: branch.id, branch: { name: 'admin' } }
#         patch :update, params: params
#         expect(assigns(:branch).name).to eq('admin')
#         expect(response).to redirect_to(branches_path)
#       end
#     end
#
#     context 'with failing params' do
#       it "renders 'edit'" do
#         params = { id: branch.id, branch: { name: nil } }
#         patch :update, params: params
#         expect(response).to render_template('edit')
#       end
#     end
#   end
#
#   describe 'GET #show' do
#     it 'updates branch' do
#       params = { id: branch.id }
#       patch :show, params: params
#       expect(assigns(:branch)).to eq(branch)
#     end
#   end
#
#   describe 'DELETE #destroy' do
#     it 'updates branch' do
#       params = { id: branch.id }
#       delete :destroy, params: params
#       expect(assigns(:branch)).to eq(branch)
#     end
#     it 'raises an exception' do
#       expect do
#         delete :destroy, params: { id: 'nothing' }
#       end.to raise_error(ActiveRecord::RecordNotFound)
#     end
#   end
# end
