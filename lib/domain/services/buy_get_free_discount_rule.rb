class BuyGetFreeDiscountRule
  def initialize(code, buy_qty: 2, get_qty: 1)
    @code = code
    @buy_qty = buy_qty
    @get_qty = get_qty
  end

  def applicable_item(checkout)
    checkout.find_item_by_product_code(@code)
  end

  def valid?(item)
    item && item.quantity >= @buy_qty
  end

  def discount(item)
    free_items = (item.quantity / @buy_qty) * @get_qty
    free_items * item.product_price
  end
end
