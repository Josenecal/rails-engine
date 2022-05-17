class Customer < ApplicationRecord

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  validates_presence_of :first_name
  validates_presence_of :last_name

end
