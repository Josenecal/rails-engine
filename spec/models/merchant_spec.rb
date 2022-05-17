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
end
