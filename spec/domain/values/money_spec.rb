describe Money do
  describe "#==" do
    it "returns true if their amount are equal" do
      expect(Money.new(1_00)).to eq(1_00)
      expect(Money.new(1_00)).to eq(Money.new(1_00))
    end
  end

  describe "to_s" do
    it "displays a human readable format" do
      expect(Money.new(1_00).to_s).to eq("1.00€")
      expect(Money.new(1_21).to_s).to eq("1.21€")
      expect(Money.new(75_50).to_s).to eq("75.50€")
    end
  end
end
