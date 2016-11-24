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

    it 'prints out several orders' do
      flower_shop = FlowerShop.new
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return("10 R12\n", "1 T58\n", "9 l09\n", 'submit')

      flower_shop.evaluate_order

      expect(STDOUT).to have_received(:puts).with(["10 R12 $12.99\n  1 x 10 $12.99\n\n\n", "1 orders are not possible with bundles\nhere is an approximate order\n3 T58 $5.95\n  1 x 3 $5.95\n\n\n", "9 L09 $24.95\n  1 x 9 $24.95\n\n\n"])
    end
  end
end
