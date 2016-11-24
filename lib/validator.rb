require_relative 'flowers.rb'

# Validates and Formats input from user
class Validator
  attr_reader :codes

  def initialize
    @codes = Flowers::CODES
  end

  def valid?(order)
    message(order).empty?
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
    'Please follow format: #{quantity} #{code}' unless message =~
                                                       /^\d+\s+\w+\n?\z/
  end

  def check_semantics(message)
    order_quantity, order_code = message.split(/\s+/)
    message = []

    message << 'Please order 1 or more flowers' unless order_quantity.to_i > 0
    message << "Please use one of the following order codes: #{codes}" unless
                                                     codes.include? order_code

    message.join(' ')
  end
end
