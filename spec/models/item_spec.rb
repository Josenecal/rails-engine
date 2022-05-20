require 'rails_helper'

RSpec.describe Item, type: :model do

  describe "relations" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through :invoice_items }
    it { should have_many(:customers).through :invoices }
    it { should have_many(:transactions).through :invoices }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe "methods" do

    it "find_by_name" do
      item1 = create(:item, name: "Dog And Cat Depot")
      item2 = create(:item, name: "Catastrophie Pet Supply")
      item3 = create(:item, name: "Vacation Alley")
      item4 = create(:item, name: "All For The Dogs")
      expected = Item.find_by_name("cat")

      # Returns expected item
      expect(expected.class).to eq Item
      expect(expected).to eq item2
    end

    it "find_by_price" do
      item1 = create(:item, unit_price: 4.99, name: "aa")
      item2 = create(:item, unit_price: 5, name: "c")
      item3 = create(:item, unit_price: 10.0, name: "B")
      item4 = create(:item, unit_price: 11, name: "d")
      expected = Item.find_by_price(5,10)

      expect(expected.class).to eq Item
      expect(expected).to eq item3
    end

  end

end
