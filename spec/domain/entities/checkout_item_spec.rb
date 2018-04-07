describe CheckoutItem do
  it "sums the price based on the quantity" do
    product = Product.new("TSHIRT", "Cabify T-Shirt", 1000)

    item = CheckoutItem.new(product, 1)
    expect(item.price).to eq(1000)

    item = CheckoutItem.new(product, 3)
    expect(item.price).to eq(3000)

    item = CheckoutItem.new(product, 6)
    expect(item.price).to eq(6000)
  end
end
