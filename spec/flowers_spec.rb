require_relative '../lib/flowers.rb'
require_relative '../lib/flower.rb'

describe Flowers do
  describe '#add(name, code, bundle_attributes)' do
    it 'adds a flower with appropriate attributes' do
      flowers = Flowers.new

      flowers.add('Rose', 'R12', 5 => 6.99, 10 => 12.99)

      expect(flowers.size).to eq 1
    end
  end

  describe '#find(code)' do
    it 'returns the flower with appropriate code' do
      flowers = Flowers.new
      flowers.add('Rose', 'R12', 5 => 6.99, 10 => 12.99)
      expected_flower = Flower.new('Rose', 'R12', 5 => 6.99, 10 => 12.99)

      flower = flowers.find('R12')

      expect(flower).to eq expected_flower
    end

    it 'raises error if code not found' do
      flowers = Flowers.new

      expect { flowers.find('R12') }.to raise_error 'Flower not found'
    end
  end

  describe '::set_up_shop' do
    it 'has a Roses, Lilies, and Tulips' do
      flowers = Flowers.set_up_shop

      roses  = flowers.find('R12')
      lilies = flowers.find('L09')
      tulips = flowers.find('T58')

      expect(roses.name).to eq 'Roses'
      expect(lilies.name).to eq 'Lilies'
      expect(tulips.name).to eq 'Tulips'
    end
  end
end
