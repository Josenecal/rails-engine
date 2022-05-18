class MerchantItemSerializer
  def self.all_items(items)
    {
      data: items.map do |item|
        {
          type: "item",
          id: item.id,
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            created_at: item.created_at,
            updated_at: item.updated_at
          }
        }
      end
    }
  end
end
