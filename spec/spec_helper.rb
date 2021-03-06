require "pry"
require_relative "./support/checkout_helpers"
require_relative "../main"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include CheckoutHelpers
end
