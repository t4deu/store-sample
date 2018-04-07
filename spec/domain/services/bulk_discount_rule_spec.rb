describe BulkDiscountRule do
  describe "#apply" do
    it "sums the total when applying varied bulk discount rule" do
      rule = BulkDiscountRule.new(:TSHIRT, qty: 4, discount: 1000)
      checkout = Checkout.new([rule])

      scan_items(checkout, "TSHIRT", "TSHIRT", "TSHIRT", "TSHIRT")

      expect(checkout.total).to eq(40_00)
    end
  end
end
