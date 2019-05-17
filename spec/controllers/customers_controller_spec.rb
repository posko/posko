require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end

  describe 'GET #index' do
    before do
      customer
      get :index
    end

    it { expect(assigns(:customers)).to eq([customer]) }
    it { expect(json).to include_json(customers: []) }
  end

  describe 'POST #create' do
    context 'with passing params' do
      let(:params) do
        {
          customer: {
            email: 'valid@email.com',
            first_name: 'first',
            last_name: 'last',
            password: 'pass'
          }
        }
      end

      before { post(:create, params: params) }

      it { expect(Customer.count).to eq(1) }
      it { expect(json).to include_json(customer: {}) }
    end

    context 'with failing params' do
      let(:params) { { customer: { name: nil } } }

      before { post(:create, params: params) }

      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'PATCH #update' do
    before { patch :update, params: params }

    context 'with passing params' do
      let(:params) do
        { id: customer.id, customer: { email: 'updated@email.com' } }
      end

      it { expect(assigns(:customer).email).to eq('updated@email.com') }
      it { expect(json).to include_json(customer: {}) }
    end

    context 'with failing params' do
      let(:params) { { id: customer.id, customer: { first_name: '' } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json).to include_json(errors: {}) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: customer.id } }

    it { expect(assigns(:customer)).to eq(customer) }
    it { expect(json).to include_json(customer: {}) }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: params }

    context 'with existing record' do
      let(:params) { { id: customer.id } }

      it { expect(assigns(:customer)).to be_destroyed }
      it { expect(json).to include_json(customer: {}) }
    end

    context 'with non-existing record' do
      let(:params) { { id: 'nothing' } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(json).to include_json(error: {}) }
    end
  end
end
