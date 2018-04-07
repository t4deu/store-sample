require "money"
require_relative "domain/aggregates/checkout"
require_relative "domain/entities/checkout_item"
require_relative "domain/entities/product"
require_relative "domain/services/bulk_discount_rule"
require_relative "domain/services/buy_get_free_discount_rule"
require_relative "domain/services/discounter"
require_relative "infrastructure/products_repository"

I18n.available_locales = :eu