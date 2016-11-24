require_relative '../lib/flower_shop.rb'

describe FlowerShop do
  describe '#evaluate_order' do
    it 'prints out an order' do
      flower_shop = FlowerShop.new
      allow(Kernel).to receive(:gets) { "11 R12\n" }

      flower_shop.evaluate_order

      expect(flower_shop).to have_received(:puts).with('15 R12 $19.98')
    end
  end
end
