require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }
  let(:account) { user.account }
  let(:invoice) { create(:invoice, account: account) }
  let(:valid_invoice_param) { { customer_id: customer.id, invoice_number: 1 } }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(account)
  end
  describe 'GET #index' do
    it 'assigns @invoices' do
      get :index
      expect(assigns(:invoices)).to eq(user.account.invoices)
    end
  end
  describe 'GET #new' do
    it 'assigns @invoice' do
      get :new
      expect(assigns(:invoice)).to be_a_new_record
    end
  end
  describe 'POST #create' do
    context 'with successful attempt' do
      before { invoice }
      it 'creates invoice' do
        # params = { invoice: valid_invoice_param }
        # TODO: Recreate this one
        # expect do
        #   post(:create, params: params)
        # end.to change(Invoice, :count).by(1)
      end
    end

    context 'with failed attempt' do
      before { invoice }
      it "renders 'new' template" do
        params = { invoice: { customer_id: nil } }
        post(:create, params: params)
        expect(response).to render_template 'new'
      end
    end
  end
  describe 'GET #edit' do
    it 'assigns @invoice' do
      params = { id: invoice.id }
      get :edit, params: params
      expect(assigns(:invoice)).to eq(invoice)
    end
  end
  describe 'PATCH #update' do
    context 'with successful attempt' do
      it 'updates invoice' do
        params = { id: invoice.id, invoice: { invoice_number: 2 } }
        patch :update, params: params
        expect(assigns(:invoice).invoice_number).to eq(2)
        expect(response).to redirect_to(invoices_path)
      end
    end
    context 'with failed attempt' do
      it "renders 'edit'" do
        params = { id: invoice.id, invoice: { invoice_number: nil } }
        patch :update, params: params
        expect(response).to render_template('edit')
      end
    end
  end
  describe 'GET #show' do
    it 'updates invoice' do
      params = { id: invoice.id }
      patch :show, params: params
      expect(assigns(:invoice)).to eq(invoice)
    end
  end
  describe 'DELETE #destroy' do
    it 'updates invoice' do
      params = { id: invoice.id }
      delete :destroy, params: params
      expect(assigns(:invoice)).to eq(invoice)
    end
    it 'raises an exception' do
      expect do
        delete :destroy, params: { id: 'nothing' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
