# Manages group of flowers
class Flowers
  attr_reader :flowers
  def initialize
    @flowers = {}
  end

  def self.set_up_shop
    domain_flowers = Flowers.new
    domain_flowers.add('Roses', 'R12', 5 => 6.99, 10 => 12.99)
    domain_flowers.add('Lilies', 'L09', 9 => 24.95, 6 => 16.95)
    domain_flowers.add('Tulips', 'T58', 3 => 5.95, 5 => 9.95, 9 => 16.99)
    domain_flowers
  end

  def add(name, code, bundle_attributes)
    flowers[code] = Flower.new(name, code, bundle_attributes)
  end

  def size
    flowers.size
  end

  def find(code)
    flower = flowers[code]
    raise ArgumentError, "Flower #{code} not found" unless flower
    flower
  end
end
