# Project: Bubble Sort for The Odin Project
# Author: Luján Fernaud
#
# Instructions:
#
# 1. Build a method #bubble_sort that takes an array and returns a
# sorted array. It must use the bubble sort methodology (using #sort would be
# pretty pointless, wouldn't it?).
#
# 2. Now create a similar method called #bubble_sort_by which sorts an array
# but accepts a block. The block should take two arguments which represent
# the two elements currently being compared. Expect that the block's return
# will be similar to the spaceship operator you learned about before -- if
# the result of the block is negative, the element on the left is "smaller"
# than the element on the right. 0 means they are equal. A positive result means
# the left element is greater. Use this to sort your array.

require 'pry'

def bubble_sort(array)
  puts "Initial array: #{array}"

  array.size.times do |i|
    last_value = i > 0 ? i * -2 : -1

    array[0..last_value].each.with_index do |_value, index|
      break if index == array.size - 1

      a = array[index]
      b = array[index + 1]

      next if a < b

      array[index] = b
      array[index + 1] = a

      print_output(array, index)
    end
  end

  puts "Final array:   #{array}"
end

def print_output(array, a_index)
  array_copy = array.dup

  array_copy.each.with_index do |value, index|
    next if index != a_index
    array_copy[index] = "[#{value}]"
    system "clear" or system "cls"
    puts "\n"
    puts array_copy.join(", ")
    sleep 0.8
    puts "\n"
  end
end

bubble_sort([4, 3, 78, 2, 0, 2])
