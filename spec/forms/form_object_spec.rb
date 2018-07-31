require 'rails_helper'

RSpec.describe FormObject, type: :model do
  let(:custom_form_class) do
    Class.new(FormObject) do
      attr_accessor :title
    end
  end

  describe 'anonymous class' do
    let(:custom_form) { custom_form_class.new(title: "Product") }
    it { expect(custom_form.title).to eq('Product') }
  end

end
