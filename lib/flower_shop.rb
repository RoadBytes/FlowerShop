require_relative 'flowers.rb'
require_relative 'flower.rb'
require_relative 'response.rb'
require_relative 'subset_on_target.rb'
require_relative 'validator.rb'

# Handles O/I from terminal
class FlowerShop
  attr_reader :flowers, :validator
  def initialize
    @flowers   = Flowers.set_up_shop
    @validator = Validator.new
  end

  def evaluate_order
    welcome_user
    orders = []

    loop do
      display_instructions
      display_order(orders)

      input = STDIN.gets.chomp.upcase
      break if input == 'SUBMIT'

      if validator.valid?(input)
        input = validator.format(input)
        orders << input
      else
        puts validator.message(input)
      end
    end

    input = orders.join("\n")

    output_results(input)
  end

  private

  def welcome_user
    system('clear')
    puts "Welcome to the Flower Shop\n\n"
  end

  def display_order(orders)
    puts 'Your current order is:'
    orders.each do |order|
      puts order
    end
    puts
  end

  def display_instructions
    puts 'Orders are in the format: #{Quantity} #{Flower Code}'
    puts "ex: '10 R12'\n\n"
    puts 'Add orders and your order will be displayed'
    puts "When finished enter 'submit' and your order will be evaluated\n\n"
    puts 'current codes:'
    puts flowers.display_flowers
    puts
  end

  def output_results(orders)
    system('clear')

    puts flowers.evaluate_order(orders)
    puts
  end
end
