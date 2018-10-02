require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }
  let(:account) { user.account }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end

  describe 'GET dashboard' do
    before do
      product = create(:product, account: account)
      create(:variant, product: product)
      get :dashboard
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:users).count).to eq 1 }
    it { expect(assigns(:variants).count).to eq 1 }
    it { expect(assigns(:products).count).to eq 1 }
    it { expect(assigns(:invoices).count).to eq 0 }
  end
end
