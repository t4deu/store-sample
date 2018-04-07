describe BuyGetFreeDiscountRule do
  describe "#apply" do
    it "sums the total when applying 3x2 discount rules" do
      rule = BuyGetFreeDiscountRule.new(:VOUCHER, buy_qty: 3, get_qty: 2)

      checkout = Checkout.new([rule])
      scan_items(checkout, "VOUCHER", "TSHIRT", "VOUCHER", "VOUCHER")
      expect(checkout.total.cents).to eq(2500)

      checkout = Checkout.new([rule])
      scan_items(checkout, "VOUCHER", "TSHIRT", "VOUCHER", "VOUCHER", "VOUCHER")
      expect(checkout.total.cents).to eq(3000)

      checkout = Checkout.new([rule])
      scan_items(checkout, "VOUCHER", "TSHIRT", "VOUCHER", "VOUCHER", "VOUCHER", "VOUCHER", "VOUCHER")
      expect(checkout.total.cents).to eq(3000)
    end
  end
end
