 This is the implementation of the [Checkout coding challenge](https://github.com/cabify/rubyChallenge), here you will find some explanations and considerations about the code.

## Core decisions
### Design
Since it's a Ruby, not Rails, challenge, I thought this would be a great opportunity to use a little DDD for the for organization of the library. The domain is defined as follows:

#### Checkout
Responsible for the main feature, product scanning, is represented by an aggregator. It calculates totals, and is the only access point for checkout items.

One interesting thing I'd like to point out is that a quantity counter is used, instead of adding a new checkout item inside the list every time a product was scanned, which would be easier.

This is because a simple but very important reason. Imagine if a customer placed an order with 200, 500 or thousands of t-shirts, the simplest implementation would be a memory and processing sinkhole.

A checkout ready for production should be able to receive several orders, regardless on the amount of items added.

#### Discount Rules

Discount rules are represented by services, each rule is responsible for applying a specific discount logic and returning the discount amount based on the settings passed to it.

There is also the `Discounter`, which is responsible for managing how and what rules are applied. It was a great way I found to remove the responsibility to manage the rules from the `Checkout`, it also uses Composition over Inheritance for higher flexibility.

#### Products
The products are represented by the `Product` entity, which defines the product and how it behaves. Also by the `ProductRepository`, responsible for dealing with data operations, it's a simple repository where persistence is memory based, but the concept would be the same for repositories that uses another form of persistence, like databases or json files.

### Money representation
Any amount of money throughout the code is represented in cents, as an integer. The reasons is to prevent miscalculations during operations caused by [Float arithmetic problems](https://stackoverflow.com/a/3730040/2611382).

I also created a `Money` value object to represent the totals in order to satisfy the defined requirements.
At first I thought about using the `Money` [gem](https://github.com/RubyMoney/money), but I noticed that it would not fulfill the requirements.

## Usage
To simplify the scanning of items I created a command line tool that can be used like this:
```
$ thor checkout:scan VOUCHER TSHIRT VOUCHER

Product             Quantity
VOUCHER             2
TSHIRT              1
SUBTOTAL            30.00€
TOTAL  25.00€

```

If you want to use the terminal, it's also very simple, here's an example of how you can do it
```
$ irb
> require "./main"
> pricing_rules = [
      BuyGetFreeDiscountRule.new(:VOUCHER, buy_qty: 2, get_qty: 1),
      BulkDiscountRule.new(:TSHIRT, qty: 3, discount: 1_00),
    ]
> co = Checkout.new(pricing_rules)
> co.scan("VOUCHER")
> co.scan("VOUCHER")
> co.scan("TSHIRT")
> co.total
```

The code is hopefully pretty self-documenting, but if you have any questions don't hesitate to send me an email.