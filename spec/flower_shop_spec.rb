require_relative '../lib/flower_shop.rb'

describe FlowerShop do
  describe '#evaluate_order' do
    it 'prints out an order' do
      flower_shop = FlowerShop.new
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return("11 R12\n", 'submit')

      flower_shop.evaluate_order

      expect(STDOUT).to have_received(:puts).with(["11 orders are not possible with bundles\nhere is an approximate order\n15 R12 $19.98\n  1 x 5 $6.99\n  1 x 10 $12.99\n\n\n"])
    end
  end
end
