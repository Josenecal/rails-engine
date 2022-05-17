class InvoiceItem < ApplicationRecord

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_one :customer, through: :invoice
  has_many :transactions, through: :invoice

  validates_presence_of :invoice_id
  validates_presence_of :item_id
  validates_presence_of :unit_price
  validates_presence_of :quantity

end
