module CheckoutHelpers
  def scan_items(checkout, *product_codes)
    product_codes.each { |code| checkout.scan(code) }
  end
end
