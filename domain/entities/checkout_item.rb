class CheckoutItem
  extend Forwardable

  def_delegator :@product, :code, :product_code
  def_delegator :@product, :price, :product_price

  attr_reader :product, :price, :quantity

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
    @price = product.price * quantity
  end
end
