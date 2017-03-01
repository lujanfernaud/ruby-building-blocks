# Project: Stock Picker for The Odin Project
# Author: Luján Fernaud
#
# Instructions: Implement a method #stock_picker that takes in an array of stock prices,
# one for each hypothetical day. It should return a pair of days representing the best day
# to buy and the best day to sell. Days start at 0.
#
# > stock_picker([17,3,6,9,15,8,6,1,10])
# => [1,4]  # for a profit of $15 - $3 == $12

def stock_picker(stock_prices)
  new_stock_prices = stock_prices.dup

  while new_stock_prices.max == new_stock_prices[0]
    new_stock_prices.shift
  end

  maximum_price = new_stock_prices.max
  maximum_price_index = new_stock_prices.index(maximum_price)

  # Delete array from maximum value on.
  new_stock_prices.map!.with_index { |price, index| price if index <= maximum_price_index }.compact!

  minimum_price = new_stock_prices.min

  puts "Best day to buy: #{stock_prices.index(minimum_price)} ($#{minimum_price})"
  puts "Best day to sell: #{stock_prices.index(maximum_price)} ($#{maximum_price})"
  puts "Profit: $#{maximum_price - minimum_price}"
end

p [17, 3, 6, 9, 15, 8, 6, 1, 10]
stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])

random_array = (2..40).to_a.shuffle
p random_array
stock_picker(random_array)
