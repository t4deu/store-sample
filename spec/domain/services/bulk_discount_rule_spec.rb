describe BulkDiscountRule do
  describe "#apply" do
    it "sums the total when applying varied bulk discount rule" do
      rule = BulkDiscountRule.new(:TSHIRT, qty: 4, discount: 1000)
      checkout = Checkout.new([rule])

      scan_items(checkout, "TSHIRT", "TSHIRT", "TSHIRT", "VOUCHER", "TSHIRT")

      expect(checkout.total.cents).to eq(4500)
    end
  end
end
