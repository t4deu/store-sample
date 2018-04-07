class Checkout
  attr_reader :items, :subtotal, :total

  def initialize(discount_rules = {})
    @items = {}
    @discounter = Discounter.new(rules: discount_rules)
    @product_repository = ProductsRepository.new
  end

  def scan(product_code)
    return unless valid_product_code?(product_code)

    item = build_item(product_code)
    add_item(item)
    collect_discount
    collect_totals
  end

  def find_item_by_product_code(product_code)
    items[product_code]
  end

  private

  def add_item(item)
    items[item.product_code] = item
  end

  def build_item(product_code)
    product = @product_repository.find(product_code)
    existing_item = find_item_by_product_code(product.code)

    if existing_item
      CheckoutItem.new(product, existing_item.quantity + 1)
    else
      CheckoutItem.new(product, 1)
    end
  end

  def collect_discount
    @discount = @discounter.apply_rules(self)
  end

  def collect_totals
    @subtotal = items.values.reduce(0) { |total, item| total + item.price }
    @total = @subtotal - @discount
  end

  def valid_product_code?(code)
    !code.nil? && %i{TSHIRT MUG VOUCHER}.include?(code.to_sym)
  end
end
