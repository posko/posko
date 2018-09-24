require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_account).and_return(user.account)
  end

  describe 'GET dashboard' do
    before { get :dashboard }

    it { expect(response).to have_http_status(:success) }
  end
end
