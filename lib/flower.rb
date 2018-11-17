# frozen_string_literal: true

# Contains the business logic for flower bundles and orders
class Flower
  attr_reader :name, :code, :bundle_attributes
  def initialize(name, code, bundle_attributes)
    @name              = name
    @code              = code
    @bundle_attributes = bundle_attributes
  end

  def ==(other)
    name == other.name &&
      code == other.code &&
      bundle_attributes == other.bundle_attributes
  end

  def bundle_approximate_order(order_quantity)
    approximate_order = smaller_order(order_quantity)
    smallest_bundle   = bundle_sizes.first

    left_over_orders = order_quantity - approximate_order.inject(:+).to_i
    until left_over_orders.negative?
      approximate_order << smallest_bundle
      left_over_orders -= smallest_bundle
    end

    approximate_order.sort
  end

  def bundle_subset_order(order_quantity)
    superset = bundle_superset(order_quantity)

    SubsetOnTarget.new(superset, order_quantity).run
  end

  def bundles_for_order(order_quantity)
    bundle_subset_order(order_quantity) ||
      bundle_approximate_order(order_quantity)
  end

  def evaluate_order(order_quantity)
    response = Response.new(order_quantity, self)
    response.evaluate_order
  end

  def to_s
    "#{name} have code: #{code}\n" \
    "Current Bundles:   #{bundle_attributes}"
  end

  private

  def bundle_sizes
    bundle_attributes.keys.sort
  end

  def bundle_superset(order_quantity)
    superset = []

    bundle_sizes.each do |bundle_size|
      bundles = order_quantity / bundle_size
      bundles.times { superset << bundle_size }
    end

    superset.sort.reverse
  end

  def smaller_order(order_quantity)
    descending_bundles_sizes = bundle_sizes.reverse
    order                    = []

    descending_bundles_sizes.each do |bundle_size|
      bundles = order_quantity / bundle_size
      bundles.times { order << bundle_size }
      order_quantity -= bundle_size * bundles

      break if order_quantity <= 0
    end

    order
  end
end
