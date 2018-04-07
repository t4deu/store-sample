class BulkDiscountRule
  def initialize(code, qty: 3, discount: 10)
    @code = code
    @qty = qty
    @discount = discount
  end

  def applicable_item(checkout)
    checkout.find_item_by_product_code(@code)
  end

  def valid?(item)
    item && item.quantity >= @qty
  end

  def discount(item)
    item.quantity * @discount
  end
end
