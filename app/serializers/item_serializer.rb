class ItemSerializer
  # Refactor Opportunity - duplicated with merchant item serializer class
  # Refactory Opportunity - also a valid spot to add a links element(element?)
  def self.all_items(items)
    {
      data: items.map do |item|
        {
          type: "item",
          id: item.id.to_s,
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: item.merchant_id
          }
        }
      end
    }
  end

  def self.find_item(item)
    {
      data: {
        type: "item",
        id: item.id.to_s,
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
        }
      }
    }
  end

  
end
