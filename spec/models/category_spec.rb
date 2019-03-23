require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category, name: 'juice') }

  describe 'Factory' do
    it 'creates necessary data' do
      expect(category).to be_present
      expect(Category.count).to eq(1)
    end
  end

  describe 'callbacks' do
    it 'executes initial_set_up before validation on create' do
      expect(category).to callback(:initial_set_up)
        .before(:validation).on(:create)
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:subcategories) }
    it { is_expected.to have_many(:classifications) }
    it { is_expected.to have_many(:products).through(:classifications) }
    it { expect(category).to belong_to(:parent).optional }
  end

  describe 'model' do
    describe 'create' do
      it { expect(category.depth).to eq(1) }
      it { expect(category.name).to eq('juice') }
      it { expect(category.directory).to eq('/juice') }
    end

    describe 'create with parent' do
      let(:child) { create(:category, parent: category, name: 'orange') }

      it { expect(child.depth).to eq(2) }
      it { expect(child.name).to eq('orange') }
      it { expect(child.directory).to eq('/juice/orange') }
    end
  end
end
