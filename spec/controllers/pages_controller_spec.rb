require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET dashboard' do
    before { get :dashboard }
    it { is_expected.to have_http_status(:success) }
  end
end
