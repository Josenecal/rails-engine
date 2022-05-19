class MerchantSerializer
  def self.all_merchants(merchants)
    {
      data: merchants.map do |merchant|
        {
          type: "merchant",
          id: merchant.id.to_s,
          attributes: {
            name: merchant.name
          }
        }
      end
    }
  end

  def self.find_merchant(merchant)
    {
      data:{
        type: "merchant",
        id: merchant.id.to_s,
        attributes: {
          name: merchant.name
        }
      }
    }
  end
end
