# frozen_string_literal: true

require_relative '../lib/validator.rb'
require_relative '../lib/flowers.rb'

describe Validator do
  describe '#message(order_line)' do
    it 'returns a syntax message if format is off' do
      order_line = ''
      validator  = Validator.new

      message = validator.message(order_line)

      expect(message).to include 'Please follow format: #{quantity} #{code}'
    end

    it 'notifies if order is too low' do
      order_line = '0 R12'
      validator  = Validator.new

      message = validator.message(order_line)

      expect(message).to include 'Please order 1 or more flowers'
    end

    it 'notifies if order code is not recognized' do
      order_line = '0 T01'
      validator  = Validator.new
      codes      = validator.codes.to_s

      message = validator.message(order_line)

      expect(message).to include codes
    end
  end

  describe '#valid?(order)' do
    it 'is true when order valid' do
      validator = Validator.new
      order = '12 R12'

      expect(validator.valid?(order)).to eq true
    end

    it 'is false when order invalid' do
      validator = Validator.new
      order = '0 R12'

      expect(validator.valid?(order)).to eq false
    end
  end

  describe '#format(order_line)' do
    it 'removes excess white space and upcases' do
      order_line = '1         r12'
      validator  = Validator.new

      formated = validator.format(order_line)

      expect(formated).to eq '1 R12'
    end
  end
end
