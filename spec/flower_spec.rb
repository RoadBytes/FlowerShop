require_relative '../lib/flower.rb'
require_relative '../lib/subset_on_target.rb'

describe Flower do
  describe '#new(name, code, bundles)' do
    it "sets the flower's attributes" do
      flower = Flower.new('Rose', 'R12', 5 => 6.99, 10 => 12.99)

      expect(flower.name).to eq 'Rose'
      expect(flower.code).to eq 'R12'
      expect(flower.batch_attributes).to eq(5 => 6.99, 10 => 12.99)
    end
  end

  describe '#==' do
    it 'is equal only when name code and batch attributes are equal' do
      flower    = Flower.new('Rose', 'R12', 5 => 6.99, 10 => 12.99)
      same      = Flower.new('Rose', 'R12', 5 => 6.99, 10 => 12.99)
      different = Flower.new('Tulip', 'T12', 5 => 6.99, 10 => 12.99)

      expect(same).to eq flower
      expect(different).not_to eq flower
    end
  end

  describe '#evaluate_order(order_quantity)' do
    it 'returns [10] for Roses order of 10' do
      roses = Flower.new('Roses', 'R12', 5 => 6.99, 10 => 12.99)

      order = roses.evaluate_order(10)

      expect(order).to eq [10]
    end

    it 'returns [5, 10] for Roses order of 14' do
      roses = Flower.new('Roses', 'R12', 5 => 6.99, 10 => 12.99)

      order = roses.evaluate_order(14)

      expect(order).to eq [5, 10]
    end

    it 'returns [3, 5, 5] for Tulips order of 13' do
      tulips = Flower.new('Tulips', 'T58', 3 => 5.95, 5 => 9.95, 9 => 16.99)

      order = tulips.evaluate_order(13)

      expect(order).to eq [3, 5, 5]
    end
  end

  describe '#bundle_subset_order(order_quantity)' do
    it 'returns a subset order if one exists' do
      order_quantity = 15
      roses          = Flower.new('Rose', 'R12', 5 => 6.99, 10 => 12.99)

      subset = roses.bundle_subset_order(order_quantity)

      expect(subset).to eq [5, 10]
    end

    it 'returns nil if no subset exists' do
      order_quantity = 16
      roses          = Flower.new('Rose', 'R12', 5 => 6.99, 10 => 12.99)

      subset = roses.bundle_subset_order(order_quantity)

      expect(subset).to eq nil
    end
  end

  describe '#budle_approximate_order(order_quantity)' do
    it 'returns an approximation order if >= order_quantity' do
      order_quantity = 16
      roses          = Flower.new('Rose', 'R12', 5 => 6.99, 10 => 12.99)

      subset = roses.bundle_approximate_order(order_quantity)

      expect(subset).to eq [5, 5, 10]
    end
  end
end
