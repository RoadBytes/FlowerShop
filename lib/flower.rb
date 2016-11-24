# Contains the business logic for flower bundles and orders
class Flower
  attr_reader :name, :code, :batch_attributes
  def initialize(name, code, batch_attributes)
    @name             = name
    @code             = code
    @batch_attributes = batch_attributes
  end

  def ==(other)
    name == other.name &&
      code == other.code &&
      batch_attributes == other.batch_attributes
  end

  def bundles_for_order(order_quantity)
    bundle_subset_order(order_quantity) ||
      bundle_approximate_order(order_quantity)
  end

  def bundle_subset_order(order_quantity)
    superset = bundle_superset(order_quantity)

    SubsetOnTarget.new(superset, order_quantity).last
  end

  def bundle_approximate_order(order_quantity)
    approximate_order = smaller_order(order_quantity)
    smallest_batch    = bundle_sizes.first

    left_over_orders  = order_quantity - approximate_order.inject(:+)
    until left_over_orders < 0
      approximate_order << smallest_batch
      left_over_orders -= smallest_batch
    end

    approximate_order.sort
  end

  private

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

  def bundle_superset(order_quantity)
    superset = []

    bundle_sizes.each do |bundle_size|
      bundles = order_quantity / bundle_size
      bundles.times { superset << bundle_size }
    end

    superset.sort
  end

  def bundle_sizes
    batch_attributes.keys.sort
  end
end
