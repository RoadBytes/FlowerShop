require_relative 'flowers.rb'

# Validates and Formats input from user
class Validator
  attr_reader :codes

  def initialize
    @codes = Flowers::CODES
  end

  def message(message)
    check_syntax(message) ||
      check_semantics(message)
  end

  def format(message)
    order_quantity, order_code = message.upcase.split(/\s+/)
    "#{order_quantity} #{order_code}"
  end

  private

  def check_syntax(message)
    unless message.match(/^\d+\s+\w+\n?\z/)
      return 'Please follow format: #{quantity} #{code}'
    end
  end

  def check_semantics(message)
    order_quantity, order_code = message.split(/\s+/)
    message = []

    unless order_quantity.to_i > 0
      message << 'Please order 1 or more flowers'
    end

    unless codes.include? order_code
      message << "Please use one of the following order codes: #{codes}"
    end

    message.join(' ')
  end
end
