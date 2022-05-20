class Merchant < ApplicationRecord

  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.find_all_by_name(query)
    Merchant
    .where("lower(name) LIKE ?", '%'+query.downcase+'%')
    .order(:name)
  end
end
