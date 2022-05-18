class MerchantSerializer
  def self.all_merchants(merchants)
    {
      data: merchants.map do |merchant|
        {
          type: "merchant",
          id: merchant.id,
          attributes: {
            name: merchant.name,
            created_at: merchant.created_at,
            updated_at: merchant.updated_at
          }
        }
      end
    }
  end
end
