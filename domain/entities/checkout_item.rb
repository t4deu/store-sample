require "forwardable"

class CheckoutItem
  extend Forwardable

  def_delegator :@product, :code, :product_code

  attr_reader :product, :price, :quantity

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
    @price = product.price * quantity
  end
end
