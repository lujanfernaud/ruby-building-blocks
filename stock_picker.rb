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
  stock_prices_copy = stock_prices.dup
  days_and_profit   = []
  profits           = []

  stock_prices_copy.each_with_index do |price1, index1|
    stock_prices.each_with_index do |price2, index2|
      # Jump to next iteration if the index of the second price is smaller or
      # equal than the index of the first price. We are only interested in
      # left to right comparisons (ex: day 2 compared to day 4).
      next if index2 < index1 || index2 == index1

      profit = price2 - price1
      next if profit < 0

      # Only save pairs with profits bigger than the ones that are already in the array.
      if days_and_profit.empty? || profit > days_and_profit[-1][2]
        days_and_profit << [stock_prices_copy.index(price1), stock_prices.index(price2), profit]
      end
    end
  end

  # Send the profits to an array to choose the highest.
  days_and_profit.each do |sub_array|
    sub_array.each_with_index { |value, index| profits << value if index == 2}
  end

  highest_profit_index = profits.index(profits.max)
  chosen_days          = days_and_profit[highest_profit_index]
  minimum_price        = stock_prices[chosen_days[0]]
  maximum_price        = stock_prices[chosen_days[1]]

  print_output(stock_prices, minimum_price, maximum_price)
end

def print_output(stock_prices, minimum_price, maximum_price)
  puts "\n"
  puts days_and_prices(stock_prices)
  puts "Best day to buy: " + "#{stock_prices.index(minimum_price)}".rjust(5) + "($#{minimum_price})".rjust(6)
  puts "Best day to sell:" + "#{stock_prices.index(maximum_price)}".rjust(5) + "($#{maximum_price})".rjust(6)
  puts "-" * 28
  puts "Profit:" + "$#{maximum_price - minimum_price}".rjust(20)
end

def days_and_prices(stock_prices)
  days        = (0..stock_prices.length - 1).to_a
  days        = days.map { |day| "%2d" % day }.join(" | ")
  prices      = stock_prices.map { |price| "%2d" % price }.join(" | ")

  puts "Day:  " + days.rjust(days.length + 2)
  puts "Price:" + prices.rjust(prices.length + 2)
end

def random_prices_generator(days)
  array = []
  days.times do |n|
    array << (n + 1) * rand(1..3)
  end
  array.shuffle!
end

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])

random_prices = random_prices_generator(14)
stock_picker(random_prices)
