# FlowerShop

High level class that manages input from user
  # (future feature) Can take in from command line or file

# Validator

Takes input from user and validates input
Makes sure their is valid syntax and semantic

- #evaluate_order
  builds an order line by line

- #valid_sematics?
  - There is a order
    order >= 0
  - There is a flower code
    - #flower_code_valid?(flower_code)
      FLOWER_CODES.include? flower_code

- INPUT_SYNTAX
  # ie '10 R12'
  /^\d+\s+\w+\n?\z/
- #valid_syntax?
  match(/^\d+\s+\w+\n?\z/)
- #parse_line(line)
  order, flower_code = line.split(/\s+/)

# Flowers

Contains information of flower bundles and prices

- CODES = ['r12', 'l09', 't58']
  VALID_CODES = Flower::CODES
- #bundle_set_for
  roses  = {5 => 6.99, 10 => 12.99}
  lilies = {9 => 24.95, 6 => 16.95}
  tulips = {3 => 5.95, 5 => 9.95, 9 => 16.99}
- bundle_quantities
  flower.keys.sort
- bundle_price
  bundles[bundle_quantity]
- #evaluate_order(code, order_size)
  - #order_set
      [9, 9, 9, 3]
  - #total: Flower costs for each bundle summed
    - if approximate "Unfortunately, your exact order could not be met" \
      "Here is an approximate order"
    - #message: ex
    "10 R12 $12.99" \
    "       1 X 10 $12.99" \
    or 
    "13 T58 $25.85" \
    "       2 X 5 $9.95" \
    "       1 X 3 $5.95" \

# Response

Fulfills an order of multiple flowers with a number of the flowers bundles

INPUT
'10 R12\n13 T58'

OUTPUT
"10 R12 $12.99" \
"       1 X 10 $12.99" \
or
"13 T58 $25.85" \
"       2 X 5 $9.95" \
"       1 X 3 $5.95" \

- #evaluate_order
  - #generate_bundle_set_from(order)
  - There is a subset on target
    - #subset_on_target?
    SubsetOnTarget.new(bundle_set, order)
  - If no subset on target, return approximate order
    for each bundle
    - start with biggest bundle_quantity
    - if filled_order > bundle_quantity
      number_of_bundles = order/bundle_quantity
      filled_order % bundle_quantity
    # see './approximate_order.rb'
  - Order Set will be comprised of bundle quantities
