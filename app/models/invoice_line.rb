class InvoiceLine < ApplicationRecord
  belongs_to :invoice
  belongs_to :variant
  belongs_to :product

  # validates :title, presence: true
  validates :price, presence: true
  # after_create :recompute_invoice

  # def recompute_invoice
  #   invoice.recompute_values
  # end
end
