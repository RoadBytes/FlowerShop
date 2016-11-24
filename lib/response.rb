# Handles output for Flower orders
class Response
  attr_reader :order, :flower, :bundles_for_order

  def initialize(order, flower)
    @order             = order
    @flower            = flower
    @bundles_for_order = flower.bundles_for_order(order)
    @bundle_break_down = nil
  end

  def evaluate_order
    output = ''
    if order == bundles_total
      output += "#{order} #{flower.code} $#{total}\n"
    else
      output += "#{order} orders are not possible with bundles\n"
      output += "here is an approximate order\n"
      output += "#{bundles_total} #{flower.code} $#{total}\n"
    end

    bundle_break_down.each do |bundle_info|
      count = bundle_info[:count]
      size  = bundle_info[:bundle_size]
      price = bundle_info[:bundle_price]
      output += "  #{count} x #{size} $#{price}\n"
    end
    output + "\n\n"
  end

  private

  def bundles_total
    bundles_for_order.inject(:+).to_i
  end

  def bundle_break_down
    @bundle_break_down || calculate_bundle_break_down
  end

  def bundles_frequency_hash
    hash = Hash.new(0)
    bundles_for_order.each { |key| hash[key] += 1 }
    hash
  end

  def calculate_bundle_break_down
    @bundle_break_down = []
    bundles_frequency_hash.each do |bundle_size, count|
      @bundle_break_down << { count: count,
                              bundle_size: bundle_size,
                              bundle_price: flower
                            .bundle_attributes[bundle_size] }
    end
    @bundle_break_down
  end

  def total
    sum = bundles_for_order.map do |bundle_size|
      flower.bundle_attributes[bundle_size]
    end.inject(:+)

    format('%.2f', sum)
  end
end
