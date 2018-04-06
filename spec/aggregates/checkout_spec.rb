describe Checkout do
  describe "#scan" do
    it "scan product by code" do
      checkout = Checkout.new

      checkout.scan("VOUCHER")

      expect(checkout.items.size).to eq(1)
      expect(checkout.items).to have_key(:VOUCHER)
    end
  end
end
