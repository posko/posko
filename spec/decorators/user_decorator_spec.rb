require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do
  let(:user) { create(:user, first_name: 'Cardo', last_name: 'Dalisay', suffix: 'Jr.') }
  describe '#name' do
    subject { user.decorate.name }
    it { is_expected.to eq('Cardo Dalisay Jr.') }
  end

  describe '#name_link' do
    subject { user.decorate.name_link }
    it { is_expected.to eq("<a href=\"/users/#{user.id}\">Cardo Dalisay Jr.</a>") }
  end
end
