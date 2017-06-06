# Project: Stock Picker for The Odin Project
# Author: Luján Fernaud
#
# Instructions: Implement a method #stock_picker that takes in an array of stock prices,
# one for each hypothetical day. It should return a pair of days representing the best day
# to buy and the best day to sell. Days start at 0.
#
# > stock_picker([17,3,6,9,15,8,6,1,10])
# => [1,4]  # for a profit of $15 - $3 == $12

# Syntactic sugar.
class Array
  def still_empty?
    empty?
  end
end

# Syntactic sugar.
class Integer
  def negative?
    self < 0
  end
end

def stock_picker(stock_prices)
  stock_prices_copy = stock_prices.dup
  days_and_profit   = []
  profits           = []

  stock_prices_copy.each_with_index do |price1, index1|
    stock_prices.each_with_index do |price2, index2|
      # Jump to next iteration if the index of the second price is smaller or
      # equal than the index of the first price. We are only interested in
      # left to right comparisons (ex: day 2 compared to day 4).
      next if index2 <= index1
      profit = price2 - price1
      next if profit.negative?

      # Only save pairs with profits bigger than the ones that are already in the array.
      if days_and_profit.empty? || profit > days_and_profit[-1][2]
        days_and_profit << [stock_prices_copy.index(price1), stock_prices.index(price2), profit]
      end
    end
  end

  if days_and_profit.still_empty?
    clear_screen
    puts "There's no possible profit for the list: #{stock_prices.join(", ")}"
    puts "\n"
    exit
  end

  # Send the profits to an array to choose the highest.
  days_and_profit.each do |sub_array|
    sub_array.each_with_index { |value, index| profits << value if index == 2}
  end

  highest_profit = profits.index(profits.max)
  chosen_days    = days_and_profit[highest_profit]
  minimum_price  = stock_prices[chosen_days[0]]
  maximum_price  = stock_prices[chosen_days[1]]

  print_output(stock_prices, minimum_price, maximum_price)
end

def print_output(stock_prices, minimum_price, maximum_price)
  days   = (0..stock_prices.size - 1).map { |day| "%2d" % day }.join(" | ")
  prices = stock_prices.map { |price| "%2d" % price }.join(" | ")

  clear_screen
  puts "Day:  " + days.rjust(days.size + 2)
  puts "-" * (days.size + 10)
  puts "Price:" + prices.rjust(prices.size + 2)
  puts "\n"
  puts "Best day to buy: " + "#{stock_prices.index(minimum_price)}".rjust(5) + "($#{minimum_price})".rjust(6)
  puts "Best day to sell:" + "#{stock_prices.index(maximum_price)}".rjust(5) + "($#{maximum_price})".rjust(6)
  puts "-" * 28
  puts "Profit:" + "$#{maximum_price - minimum_price}".rjust(20)
end

def check_user_input(user_input)
  user_input_array = user_input.scan(/\d+/).map { |n| n.to_i }

  if user_input == "gen"
    stock_picker(random_prices_generator)
  elsif user_input_array.empty?
    clear_screen
    puts "Please introduce a list of numbers sepparated by commas (for example: 17, 3, 6, 9, 15, 8, 6, 1, 10):"
    user_input = gets.chomp
    check_user_input(user_input)
  elsif user_input_array.size < 2
    clear_screen
    puts "Please introduce 2 numbers or more:"
    user_input = gets.chomp
    check_user_input(user_input)
  else
    stock_picker(user_input_array)
  end
end

def random_prices_generator
  Array.new(14) { rand(1..21) }
end

def clear_screen
  system "clear" or system "cls"
end

user_says = "yes"

loop do
  if user_says == "yes"
    clear_screen
    puts "##################"
    puts "#                #"
    puts "#  STOCK PICKER  #"
    puts "#                #"
    puts "##################"
    puts "\n"
    puts "Please introduce a list of prices (for example: 17, 3, 6, 9, 15, 8, 6, 1, 10):"
    puts "(You can also type 'gen' to generate random prices.)"
    user_input = gets.chomp

    clear_screen
    check_user_input(user_input)

    puts "\n"
    puts "Would you like to try again? (yes/no)"
    user_says = gets.chomp.downcase
  else
    clear_screen
    puts "Thanks for testing it. Hope you liked it!"
    puts "\n"
    break
  end
end
