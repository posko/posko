class OptionValue < ApplicationRecord
  has_many :variants, dependent: :destroy
  has_many :option_value_varaints, dependent: :destroy
  has_many :variants, through: :option_value_varaints

  belongs_to :option_type

  validates :name, presence: true
end
