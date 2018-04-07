class Money
  attr_reader :cents, :currency

  def initialize(cents, currency = "€")
    @cents = cents
    @currency = currency
  end

  def ==(other)
    (other.respond_to?(:cents) && cents == other.cents) || cents == other
  end

  def to_s
    format("%.2f#{currency}", cents / 100.00)
  end
end
