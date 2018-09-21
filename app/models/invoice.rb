class Invoice < ApplicationRecord
  enum invoice_status: [:drafted, :unfulfilled, :fulfilled]

  has_many :invoice_lines, dependent: :destroy
  has_many :transactions, dependent: :destroy
  belongs_to :account
  belongs_to :user
  belongs_to :customer, optional: true

  validates :invoice_number, presence: true
  validates :total_line_items_price, presence: true
  validates :total_discounts, presence: true
  validates :subtotal, presence: true
  validates :total_price, presence: true
  validates :total_tax, presence: true
  validates :total_weight, presence: true

  # Temporary code to comply to invoices requirement
  before_validation :pass_validations, on: :create
  # before_validation :compute_values, on: :create

  # remove this if Service objects are ready
  def pass_validations
    self.total_line_items_price ||= 0
    self.total_discounts ||= 0
    self.subtotal ||= 0
    self.total_price ||= 0
    self.total_tax ||= 0
    self.total_weight ||= 0
  end

  # def compute_values
  #   invoice_lines_collection = invoice_lines.active_status.sum("invoice_lines.price")
  #   self.total_line_items_price = invoice_lines_collection
  # end
  #
  # def recompute_values
  #   compute_values
  #   save
  # end
end
