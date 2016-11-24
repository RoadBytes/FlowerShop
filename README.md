# FlowerShop!

The **MOST Amazing** application to hit consoles near you.


```
Welcome to the Flower Shop

Orders are in the format: #{Quantity} #{Flower Code}
ex: '10 R12'

Add orders and your order will be displayed
When finished enter 'submit' and your order will be evaluated

current codes:
Roses have code: R12
Current Bundles:   {5=>6.99, 10=>12.99}
Lilies have code: L09
Current Bundles:   {9=>24.95, 6=>16.95}
Tulips have code: T58
Current Bundles:   {3=>5.95, 5=>9.95, 9=>16.99}

Your current order is:

12 R12
```

After submitting your order:

```
12 orders are not possible with bundles
here is an approximate order
15 R12 %19.98
  1 x 5 %6.99
  1 x 10 %12.99
```

## Commands description

> Orders are in the format: #{Quantity} #{Flower Code}
> ex: '10 R12'
>
> Add orders and your order will be displayed

Orders must be greater than 0 with proper flower codes %w(R12 L09 T58)
Input is case insensitive as it will be formated properly by the `Validator`

* To try it out:
  1. copy or fork the repo https://github.com/RoadBytes/FlowerShop.git
  2. run `ruby lib/app.rb` from the root folder

  see: APPLICATION INSTALLATION INSTRUCTIONS for more details

---

# ENVIRONMENTS

* This application was developed on: Mac OS X 10.10.5

---

# SYSTEM DEPENDENCIES & CONFIGURATION

* ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin14]

---

# APPLICATION INSTALLATION INSTRUCTIONS

## To install application:

### From your terminal

  TODO
* `https://github.com/RoadBytes/FlowerShop.git`
* `cd FlowerShop`
* `bundle install`
* `ruby lib/app.rb`

---

# TESTING INSTRUCTIONS

### From the root folder `FlowerShop`

* run: `rspec spec`

---

# OVERVIEW

## The application is designed to read strings from $stdin and prints out the current state of a board to $stdout.

* You can input several orders and it will be submitted once when you input
  `submit`:

## INPUT FORMAT

input passed into the program line by line and submitted at the end

## OUTPUT FORMAT

output will be printed on the terminal screen with your order:

```
12 orders are not possible with bundles
here is an approximate order
15 R12 %19.98
  1 x 5 %6.99
  1 x 10 %12.99
```

---

# DESIGN

TODO: coming soon.

---

# For Gracious Code reviewers

## REQUIREMENTS OF THE ASSIGNMENT

see 'flower_shop.pdf'

## Deliverables:

The source files, the test data and any test code.
