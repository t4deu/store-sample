describe ProductsRepository do
  describe "#find" do
    it "finds a valid product" do
      product = repository.find("MUG")

      expect(product.code).to eq(:MUG)
    end

    it "returns nothing for an invalid product" do
      product = repository.find("JACKET")

      expect(product).to be_nil
    end

    def repository
      ProductsRepository.new
    end
  end
end
