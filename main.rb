require "forwardable"
require_relative "lib/domain/aggregates/checkout"
require_relative "lib/domain/entities/checkout_item"
require_relative "lib/domain/entities/product"
require_relative "lib/domain/services/bulk_discount_rule"
require_relative "lib/domain/services/buy_get_free_discount_rule"
require_relative "lib/domain/services/discounter"
require_relative "lib/domain/values/money"
require_relative "lib/infrastructure/products_repository"