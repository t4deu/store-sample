class ProductsRepository
  def initialize
    mug = Product.new("MUG", "Cafify Coffee Mug", 75)
    tshirt = Product.new("TSHIRT", "Cabify T-Shirt", 200)
    voucher = Product.new("VOUCHER", "Cabify Voucher", 50)

    build_inventory(mug, tshirt, voucher)
  end

  def find(code)
    @inventory[code.to_sym]
  end

  private

  def build_inventory(*products)
    @inventory = products.map { |product| [product.code, product] }.to_h
  end
end
