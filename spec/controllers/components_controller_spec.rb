require 'rails_helper'

RSpec.describe ComponentsController, type: :controller do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:product) { create(:product, account: account) }
  let(:variant) { create(:variant, product: product) }
  let(:component) { create(:component, variant: variant) }
  let(:valid_component_param) { { quantity: 1, cost: 99.9 } }
  before { sign_in }
  describe "GET #index" do
    it "assigns @components" do
      get :index, params: { variant_id: variant.id }
      expect(assigns(:components)).to eq([component])
    end
  end
  describe "GET #new" do
    it "assigns @component" do
      get :new, params: { variant_id: variant.id }
      expect(assigns(:component)).to be_a_new_record
    end
  end
  describe "POST #create" do
    context "successful attempt" do
      let(:params) { { component: valid_component_param, variant_id: variant.id } }
      before { post(:create, params: params) }
      it "creates component" do
        expect(variant.components.count).to eq(1)
      end
    end

    context "failed attempt" do
      before { component }
      it "renders 'new' template" do
        params = { component: { quantity: nil, cost: 99 }, variant_id: variant.id }
        post(:create, params: params)
        expect(response).to render_template "new"
      end
    end
  end
  describe "GET #edit" do
    it "assigns @component" do
      params = { id: component.id }
      get :edit, params: params
      expect(assigns(:component)).to eq(component)
    end
  end
  describe "PATCH #update" do
    context "successful attempt" do
      it "updates component" do
        params = { id: component.id, component: { quantity: 2, cost: 99 } }
        patch :update, params: params
        expect(assigns(:component).quantity).to eq(2)
        expect(response).to redirect_to(variant_components_path(variant.id))
      end
    end
    context "failed attempt" do
      it "renders 'edit'" do
        params = { id: component.id, component: { quantity: nil } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end
  describe "GET #show" do
    it "updates component" do
      params = { id: component.id }
      patch :show, params: params
      expect(assigns(:component)).to eq(component)
    end
  end
  describe "DELETE #destroy" do
    it "updates component" do
      params = { id: component.id }
      delete :destroy, params: params
      expect(assigns(:component)).to eq(component)
      expect(assigns(:component).deleted_status?).to be_truthy
    end
    it "raises an exception" do
      expect { delete :destroy, params: { id: "nothing" } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
