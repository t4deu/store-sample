describe Checkout do
  describe "#scan" do
    it "scans a product code" do
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

    it "only accept valid products" do
      checkout = Checkout.new

      scan_items(checkout, nil, "BED", "CAR", "JACKET")

      expect(checkout.items).to be_empty
    end
  end

  describe "#subtotal" do
    it "sums the subtotal for multiple items with the same type" do
      checkout = Checkout.new

      scan_items(checkout, "TSHIRT", "TSHIRT")

      expect(checkout.subtotal).to eq(4000)
    end

    it "sums the subtotal for multiple items with different types" do
      checkout = Checkout.new

      scan_items(checkout, "MUG", "TSHIRT", "VOUCHER")

      expect(checkout.subtotal).to eq(3250)
    end
  end

  describe "#items" do
    it "returns an empty list" do
      checkout = Checkout.new

      expect(checkout.items).to be_empty
    end

    it "returns a list of checkout items" do
      checkout = Checkout.new

      scan_items(checkout, "MUG", "TSHIRT", "VOUCHER")

      expect(checkout.items.size).to eq(3)
      expect(checkout.items.values).to all(be_an(CheckoutItem))
    end
  end

  def scan_items(checkout, *product_codes)
    product_codes.each { |code| checkout.scan(code) }
  end
end
