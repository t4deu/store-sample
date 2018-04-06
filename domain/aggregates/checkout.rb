class Checkout
  attr_reader :items

  def initialize()
    @items = {}
    @product_repository = ProductsRepository.new
  end

  def scan(product_code)
    product = @product_repository.find(product_code)
    existing_item = find_item_by_product(product)

    item = if existing_item
             CheckoutItem.new(product, existing_item.quantity + 1)
           else
             CheckoutItem.new(product, 1)
           end

    add_item(item)
  end

  private

  def add_item(item)
    items[item.product_code] = item
  end

  def find_item_by_product(product)
    items[product.code]
  end
end
