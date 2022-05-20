class Item < ApplicationRecord

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.find_by_name(query)
    where("lower(name) LIKE ?", '%'+query.downcase+'%')
    .order(:name)
    .first
  end

  def self.find_by_price(min, max)
    where(unit_price: min..max)
    .order('lower(name)') # Triggers SQL injection warning? 
    .first
  end
end
