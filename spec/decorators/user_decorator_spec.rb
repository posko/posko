require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do

  describe '#name' do
    let(:user) { build(:user, first_name: "Cardo", last_name: "Dalisay", suffix: "Jr.") }
    subject { user.decorate.name }
    it { is_expected.to eq("Cardo Dalisay Jr.") }
  end
end
