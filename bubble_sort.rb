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

def bubble_sort(array)
  array.size.times do |i|
    last_value = i > 0 ? i * -1 : -1

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
end

def bubble_sort_by(array)
  array.size.times do |i|
    last_value = i > 0 ? i * -1 : -1

    array[0..last_value].each.with_index do |_value, index|
      break if index == array.size - 1

      a = array[index]
      b = array[index + 1]

      next if a.is_a?(String) && b.is_a?(String) && yield(a.to_s, b.to_s) < 0
      next if a.is_a?(Integer) && b.is_a?(Integer) && yield(a, b) == true

      array[index] = b
      array[index + 1] = a

      print_output(array, index)
    end
  end
end

def print_output(array, a_index)
  array_copy = array.dup
  array_copy.each.with_index do |value, index|
    next if index != a_index
    array_copy[index] = "[#{value}]"
    system "clear" or system "cls"
    puts "\n"
    puts array_copy.join(", ")
    sleep 0.4
    puts "\n"
  end
end

def random_list
  array = (0..((rand(2..3)) * 5)).to_a.shuffle
  array.shuffle! if array.sort == array
  array
end

# bubble_sort([4, 3, 78, 2, 0, 2])
# => [0, 2, 2, 3, 4, 78]

# bubble_sort_by(["hi", "hello", "hey"]) { |a, b| a.length - b.length }
# => ["hi", "hey", "hello"]

bubble_sort_by(random_list) { |a, b| a < b }
