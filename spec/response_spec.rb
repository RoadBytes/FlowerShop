# frozen_string_literal: true

require_relative '../lib/response.rb'
require_relative '../lib/flower.rb'
require_relative '../lib/subset_on_target.rb'

describe Response do
  describe 'evaluate_order' do
    it 'prints out the order when exact' do
      roses    = Flower.new('Rose', 'R12', 3 => 5.95, 5 => 9.95, 9 => 16.99)
      response = Response.new(10, roses)

      output = response.evaluate_order

      expect(output).to include('10 R12 $19.90')
      expect(output).to include('2 x 5 $9.95')
    end

    it 'prints out the approximate order when not exact' do
      roses    = Flower.new('Rose', 'R12', 3 => 5.95, 5 => 9.95, 9 => 16.99)
      response = Response.new(2, roses)

      output = response.evaluate_order

      expect(output).to include('2 orders are not possible with bundles')
      expect(output).to include('here is an approximate order')
      expect(output).to include('3 R12 $5.95')
      expect(output).to include('1 x 3 $5.95')
    end
  end
end
