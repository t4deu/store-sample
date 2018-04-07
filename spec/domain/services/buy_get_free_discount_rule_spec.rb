describe BuyGetFreeDiscountRule do
  describe "#apply" do
    it "sums the total when applying 3x2 discount rules" do
      rule = BuyGetFreeDiscountRule.new(:VOUCHER, buy_qty: 3, get_qty: 2)

      checkout = Checkout.new([rule])
      scan_items(checkout, "VOUCHER", "TSHIRT", "VOUCHER", "VOUCHER")
      expect(checkout.total).to eq(25_00)

      checkout = Checkout.new([rule])
      scan_items(checkout, "VOUCHER", "TSHIRT", "VOUCHER", "VOUCHER", "VOUCHER")
      expect(checkout.total).to eq(30_00)

      checkout = Checkout.new([rule])
      scan_items(checkout, "VOUCHER", "TSHIRT", "VOUCHER", "VOUCHER", "VOUCHER", "VOUCHER", "VOUCHER")
      expect(checkout.total).to eq(30_00)
    end
  end
end
