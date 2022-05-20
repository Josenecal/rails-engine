require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do

    it { should validate_presence_of :name }

  end

  describe "relations" do

    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many :customers }
    it { should have_many :transactions }

  end

  describe "methods" do

    it "self.find_all_by_name returns all matching names" do
      merchant1 = create(:merchant, name: "Ronald Regan")
      merchant2 = create(:merchant, name: "Aaron Industrial")
      merchant3 = create(:merchant, name: "Erin and Kelly Kitchens")
      expected = Merchant.find_all_by_name("ron")

      expect(expected.include?(merchant1)).to eq true
      expect(expected.include?(merchant2)).to eq true
      expect(expected.include?(merchant3)).to eq false
    end

  end
end
