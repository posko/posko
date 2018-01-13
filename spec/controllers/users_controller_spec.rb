require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_user_param) { { email: "valid@email.com", first_name: "first", last_name: "last", password: "pass" } }
  before { allow(controller).to receive(:current_user).and_return(user) }
  describe "GET #index" do
    it "assigns @users" do
      get :index
      expect(assigns(:users)).to eq([user])
    end
  end
  describe "GET #new" do
    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_a_new_record
    end
  end
  describe "POST #create" do
    before { user }
    it "creates user" do
      params = { user: valid_user_param }
      expect{post(:create, params: params)}.to change(User, :count).by(1)
    end
  end
  describe "GET #edit" do
    it "assigns @user" do
      params = {id: user.id}
      get :edit, params: params
      expect(assigns(:user)).to eq(user)
    end
  end
  describe "PATCH #update" do
    it "updates user" do
      params = { id: user.id, user: { email: "updated_email" }}
      patch :update, params: params
      expect(assigns(:user).email).to eq("updated_email")
    end
  end
  describe "GET #show" do
    it "updates user" do
      params = { id: user.id }
      patch :show, params: params
      expect(assigns(:user)).to eq(user)
    end
  end
  describe "DELETE #destroy" do
    it "updates user" do
      params = { id: user.id }
      delete :destroy, params: params
      expect(assigns(:user)).to eq(user)
    end
    it "raises an exception" do
      expect{ delete :destroy, params: { id:"nothing" } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
