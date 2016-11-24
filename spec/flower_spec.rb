require_relative '../lib/flower.rb'

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
    # TODO
  end
end
