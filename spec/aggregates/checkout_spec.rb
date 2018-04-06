describe Checkout do
  describe "#scan" do
    it "scan product by code" do
      checkout = Checkout.new

      scan_items(checkout, "VOUCHER")

      expect(checkout.items.size).to eq(1)
      expect(checkout.items).to have_key(:VOUCHER)
    end

    it "doesn't duplicate an existing product" do
      checkout = Checkout.new

      scan_items(checkout, "TSHIRT", "TSHIRT")

      expect(checkout.items.size).to eq(1)
      expect(checkout.items).to have_key(:TSHIRT)
    end

    it "increments the quantity of an existing product" do
      checkout = Checkout.new

      scan_items(checkout, "TSHIRT", "TSHIRT", "TSHIRT")

      code, item = checkout.items.first

      expect(item.product_code).to eq(:TSHIRT).and eq(code)
      expect(item.quantity).to eq(3)
    end

    it "scans multiple products in any order" do
      checkout = Checkout.new

      scan_items(checkout, "TSHIRT", "MUG", "TSHIRT", "VOUCHER")

      expect(checkout.items.size).to eq(3)
      expect(checkout.items.keys).to eq(%i{TSHIRT MUG VOUCHER})
    end
  end

  def scan_items(checkout, *product_codes)
    product_codes.each { |code| checkout.scan(code) }
  end
end
