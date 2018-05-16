require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }
  let(:session) { { user_id: user.id } }
  describe '#current_user' do
    it "returns current user" do
      allow(controller).to receive(:session).and_return(session)
      expect(subject.current_user).to eq(user)
    end
  end

  describe '#current_account' do
    it "returns current account" do
      allow(controller).to receive(:session).and_return(session)
      expect(subject.current_account).to eq(user.account)
    end
  end

  describe '#check_session' do
    controller do
      def index; end
    end
    it "returns current account" do
      get :index
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
