require "./main"

class App < Thor
  namespace :checkout

  desc "scan", "scans a product"
  long_desc <<-LONGDESC.gsub("\n", "\x5")
    `scan` allows items to be scanned in any order, and returns the total amount to be paid.
    Usage Examples:
    `$ thor checkout:scan VOUCHER TSHIRT VOUCHER`
  LONGDESC

  def scan(*codes)
    checkout = Checkout.new(pricing_rules)
    codes.each { |code| checkout.scan(code) }

    if checkout.empty?
      say "Empty checkout"
    else
      print_checkout(checkout)
    end

  end

  private

  def pricing_rules
    [
      BuyGetFreeDiscountRule.new(:VOUCHER, buy_qty: 2, get_qty: 1),
      BulkDiscountRule.new(:TSHIRT, qty: 3, discount: 100),
    ]
  end

  def print_checkout(checkout)
    table = [["Product", "Quantity"]]
    scanned_items = checkout.items.values.map { |item| [item.product_code, item.quantity.to_s] }
    subtotal = [["SUBTOTAL", checkout.subtotal]]
    total = [[set_color("TOTAL", :red, :bold), set_color(checkout.total, :red)]]

    table = table + scanned_items + subtotal + total

    print_table(table)
  end
end
