class Discounter
  attr_reader :rules
  def initialize(rules: [])
    @rules = rules
  end

  def apply_rules(checkout)
    rules.reduce(0) {|total, rule| total + apply_rule(rule, checkout) }
  end

  private

  def apply_rule(rule, checkout)
    applicable_item = rule.applicable_item(checkout)

    if rule.valid?(applicable_item)
      rule.discount(applicable_item)
    else
      0
    end
  end
end