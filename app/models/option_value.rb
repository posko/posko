class OptionValue < ApplicationRecord
  has_many :variants, dependent: :destroy

  belongs_to :option_type

  validates :name, presence: true
end
