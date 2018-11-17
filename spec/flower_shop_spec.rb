# frozen_string_literal: true

require_relative '../lib/flower_shop.rb'

describe FlowerShop do
  describe '#evaluate_order' do
    it 'prints out an order' do
      flower_shop = FlowerShop.new
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return("11 R12\n", 'submit')
      text = "11 orders are not possible with bundles\n" \
               "here is an approximate order\n15 R12 $19.98\n" \
               "  1 x 5 $6.99\n  1 x 10 $12.99\n\n\n"

      flower_shop.evaluate_order

      expect(STDOUT).to have_received(:puts).with([text])
    end

    it 'prints out several orders' do
      inputs = ["10 R12\n", "1 T58\n", "9 l09\n", 'submit']
      flower_shop = FlowerShop.new
      allow(STDOUT).to receive(:puts)
      allow(STDIN).to receive(:gets).and_return(*inputs)
      tulip_order = "1 orders are not possible with bundles\n" \
                    "here is an approximate order\n" \
                    "3 T58 $5.95\n  1 x 3 $5.95\n\n\n"
      output = ["10 R12 $12.99\n  1 x 10 $12.99\n\n\n",
                tulip_order,
                "9 L09 $24.95\n  1 x 9 $24.95\n\n\n"]

      flower_shop.evaluate_order

      expect(STDOUT).to have_received(:puts).with(output)
    end
  end
end
