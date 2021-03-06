require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe "relations" do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_one :merchant }
    it { should have_one(:customer).through :invoice }
    it { should have_many(:transactions).through :invoice }
  end

  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end

end
