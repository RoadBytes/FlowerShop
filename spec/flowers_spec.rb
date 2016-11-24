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

  describe '#display_flowers' do
    it 'displays flower attributes' do
      flowers = Flowers.new
      flowers.add('Rose', 'R12', 5 => 6.99, 10 => 12.99)
      flower = flowers.find('R12')

      output = flowers.display_flowers

      expect(output).to include flower.to_s
    end
  end

  describe '#evaluate_order(orders)' do
    it 'sends orders to correct flower' do
      orders = "12 R12\n15 L09"
      roses  = instance_double('Flower')
      lilies = instance_double('Flower')
      allow(Flower).to receive(:new).with('Rose', 'R12',
                                          5 => 6.99, 10 => 12.99) { roses }
      allow(Flower).to receive(:new).with('Lilies', 'L09',
                                          5 => 6.99, 10 => 12.99) { lilies }
      flowers = Flowers.new
      flowers.add('Rose', 'R12', 5 => 6.99, 10 => 12.99)
      flowers.add('Lilies', 'L09', 5 => 6.99, 10 => 12.99)
      allow(roses).to receive(:evaluate_order)
      allow(lilies).to receive(:evaluate_order)

      flowers.evaluate_order(orders)

      expect(roses).to have_received(:evaluate_order).with(12)
      expect(lilies).to have_received(:evaluate_order).with(15)
    end
  end

  describe '#evaluate_order_line(order_line)' do
    it 'sends order to correct flower' do
      roses = instance_double('Flower')
      allow(Flower).to receive(:new) { roses }
      flowers = Flowers.new
      flowers.add('Rose', 'R12', 5 => 6.99, 10 => 12.99)
      allow(roses).to receive(:evaluate_order).with(10)

      flowers.evaluate_order('10 R12')

      expect(roses).to have_received(:evaluate_order).with(10)
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

      expect { flowers.find('R12') }.to raise_error 'Flower R12 not found'
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
