class Category < ApplicationRecord
  belongs_to :account
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: :parent_id,
                           dependent: :destroy, inverse_of: :parent
  has_many :classifications, dependent: :destroy
  has_many :products, through: :classifications

  validates :name, presence: true, uniqueness: true
  validates :directory, uniqueness: true

  before_validation :initial_set_up, on: :create

  def initial_set_up
    set_depth
    set_directory
  end

  def set_depth
    self.depth = parent ? parent.depth + 1 : 1
  end

  def set_directory
    self.directory = if parent
                       "#{parent.directory}/#{name.parameterize}"
                     else
                       "/#{name.parameterize}"
                     end
  end

  def self.first_level
    where(depth: 1)
  end
end
