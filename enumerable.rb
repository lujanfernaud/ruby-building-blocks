# Project: Enumerable Methods for The Odin Project
# Author: Luján Fernaud
#
# Instructions:
#
# 1. Create a script file to house your methods and run it in IRB
# to test them later.
#
# 2. Add your new methods onto the existing Enumerable module.

require 'pry'

module Enumerable
  # 3. Create #my_each, a method that is identical to #each but (obviously)
  # does not use #each. You'll need to remember the yield statement. Make sure
  # it returns the same thing as #each as well.
  def my_each
    return to_enum unless block_given?
    i = 0
    array = []
    while i < size
      yield to_a[i]
      array << to_a[i]
      i += 1
    end
    array
  end

  # 4. Create #my_each_with_index in the same way.
  def my_each_with_index
    return to_enum unless block_given?
    i = 0
    array = []
    while i < size
      yield to_a[i], i
      array << to_a[i]
      i += 1
    end
    array
  end

  # 5. Create #my_select in the same way, though you may use #my_each in your
  # definition (but not #each).
  def my_select
    return to_enum unless block_given?
    array = []
    to_a.my_each { |n| array.push(n) if yield(n) }
    array
  end

  # 6. Create #my_all? (continue as above)
  def my_all?
    return my_all? { |n| n } unless block_given?
    array = []
    to_a.my_each { |n| array.push(n) if yield(n) }
    array.size == size
  end

  # 7. Create #my_any?
  def my_any?
    return my_any? { |n| n } unless block_given?
    array = []
    to_a.my_each { |n| array.push(n) if yield(n) }
    !array.empty?
  end

  # 8. Create #my_none?
  def my_none?
    return !my_any? { |n| yield(n) } if block_given?
    array = []
    to_a.my_each { |n| array.push(n) if !!n == true }
    array.empty?
  end

  # 9. Create #my_count
  def my_count(item = false)
    return size if item == false && !block_given?
    array = []
    if item
      to_a.my_each { |n| array.push(n) if n == item }
    else
      to_a.my_each { |n| array.push(n) if yield(n) }
    end
    array.size
  end

  # 10. Create #my_map
  def my_map
    return to_enum unless block_given?
    array = []
    to_a.my_each { |n| array.push(yield n) }
    array
  end

  # 11. Create #my_inject
  def my_inject(accumulator = nil, operator = false)
    if block_given?
      accumulator ||= first
      my_each_with_index do |n, index|
        next if index.zero? && n == accumulator
        accumulator = yield(accumulator, n)
      end
    else
      raise LocalJumpError, "no block given" if accumulator == nil && operator == false
      # If the method has been called only with one parameter
      # then the operator has been saved in the accumulator.
      if operator == false
        raise TypeError, "#{accumulator} is not a symbol nor a string" if accumulator.is_a?(Integer)
        operator = accumulator.to_sym
        accumulator = first
      end

      my_each_with_index do |n, index|
        next if index.zero? && n == accumulator
        case operator
        when :+  then accumulator  += n
        when :-  then accumulator  -= n
        when :*  then accumulator  *= n
        when :** then accumulator **= n
        when :/  then accumulator  /= n
        when :%  then accumulator  %= n
        when :<< then accumulator <<= n
        when :>> then accumulator >>= n
        when :&  then accumulator  &= n
        when :|  then accumulator  |= n
        end
      end
    end
    accumulator
  end

  # 12. Test your #my_inject by creating a method called #multiply_els which
  # multiplies all the elements of the array together by using #my_inject,
  # e.g. multiply_els([2,4,5]) #=> 40
  def multiply_els(_array = false)
    my_inject(:*)
  end

  # 13. Modify your #my_map method to take a proc instead.

  # 14. Modify your #my_map method to take either a proc or a block.
  # It won't be necessary to apply both a proc and a block in the same
  # #my_map call since you could get the same effect by chaining together
  # one #my_map call with the block and one with the proc. This approach is also
  # clearer, since the user doesn't have to remember whether the proc or block
  # will be run first. So if both a proc and a block are given, only execute
  # the proc.
end

# 12. Test your #my_inject by creating a method called #multiply_els which
# multiplies all the elements of the array together by using #my_inject,
# e.g. multiply_els([2,4,5]) #=> 40
def multiply_els(array)
  array.my_inject(:*)
end

array = [1, 3, 5, 6, 7, 9, 14, 21]

puts"\n"
puts "########################"
puts "#                      #"
puts "#  ENUMERABLE METHODS  #"
puts "#                      #"
puts "########################"
puts "\n"

puts "p array.my_each:"
p array.my_each { |n| "#{n}!" }
puts "\np array.each:"
p array.each { |n| "#{n}!" }
puts "\narray.my_each with puts in block:"
array.my_each { |n| puts "#{n}!" }
puts "\narray.each with puts in block:"
array.each { |n| puts "#{n}!" }
puts "\narray.my_each without block:"
p array.my_each
puts "\narray.each without block:"
p array.each

puts "\n------------------------\n"

puts "\np array.my_each_with_index:"
p array.my_each_with_index { |n, i| "Number #{n} has index #{i}" }
puts "\np array.each_with_index:"
p array.each_with_index { |n, i| "Number #{n} has index #{i}" }
puts "\narray.my_each_with_index with puts in block:"
array.my_each_with_index { |n, i| puts "Number #{n} has index #{i}" }
puts "\narray.each_with_index with puts in block:"
array.each_with_index { |n, i| puts "Number #{n} has index #{i}" }
puts "\narray.my_each_with_index without block:"
p array.my_each_with_index
puts "\narray.each_with_index without block:"
p array.each_with_index

puts "\n------------------------\n"

puts "\np array.my_select:"
p array.my_select { |n| n.odd? }
puts "\np array.select:"
p array.select { |n| n.odd? }
puts "\narray.my_select with puts in block:"
array.my_select { |n| puts n if n.odd? }
puts "\narray.select with puts in block:"
array.select { |n| puts n if n.odd? }
puts "\narray.my_select without block:"
p array.my_select
puts "\narray.select without block:"
p array.select

puts "\n------------------------\n"

puts "\np array.my_all? (n < 9):"
p array.my_all? { |n| n < 9 }
puts "\np array.all? (n < 9):"
p array.all? { |n| n < 9 }
puts "\np array.my_all? without block:"
p array.my_all?
puts "\np array.all? without block:"
p array.all?

puts "\n------------------------\n"

puts "\np array.my_any? (n < 9):"
p array.my_any? { |n| n < 9 }
puts "\np array.any? (n < 9):"
p array.any? { |n| n < 9 }
puts "\np array.my_any? without block:"
p array.my_any?
puts "\np array.any? without block:"
p array.any?

puts "\n------------------------\n"

puts "\np array.my_none? (n < 9):"
p array.my_none? { |n| n < 9 }
puts "\np array.none? (n < 9):"
p array.none? { |n| n < 9 }
puts "\np array.my_none? without block:"
p array.my_none?
puts "\np array.none? without block:"
p array.none?

puts "\n------------------------\n"

puts "\np array.my_count(3):"
p array.my_count(3)
puts "\np array.count(3):"
p array.count(3)
puts "\np array.my_count (n < 9):"
p array.my_count { |n| n < 9 }
puts "\np array.count (n < 9):"
p array.count { |n| n < 9 }
puts "\np array.my_count without block:"
p array.my_count
puts "\np array.count without block:"
p array.count

puts "\n------------------------\n"

puts "\np array.my_map (n if n < 9):"
p array.my_map { |n| n if n < 9 }
puts "\np array.map (n if n < 9):"
p array.map { |n| n if n < 9 }
puts "\np array.my_map without block:"
p array.my_map
puts "\np array.map without block:"
p array.map

puts "\n------------------------\n"

puts "\narray.my_inject (sum + n):"
p array.my_inject { |sum, n| sum + n }
puts "\narray.inject (sum + n):"
p array.inject { |sum, n| sum + n }
puts "\narray.my_inject(9) (sum + n):"
p array.my_inject(9) { |sum, n| sum + n }
puts "\narray.inject(9) (sum + n):"
p array.inject(9) { |sum, n| sum + n }
puts "\narray.my_inject(:*):"
p array.my_inject(:*)
puts "\narray.inject(:*):"
p array.inject(:*)
puts "\narray.my_inject(3, :*):"
p array.my_inject(3, :*)
puts "\narray.inject(3, :*):"
p array.inject(3, :*)
puts "\narray.my_inject('<<'):"
p array.my_inject("<<")
puts "\narray.inject('<<'):"
p array.inject("<<")

puts "\n------------------------\n"

puts "\narray.multiply_els:"
p array.multiply_els
puts "\nmultiply_els([2, 4, 5]):"
p multiply_els([2, 4, 5])
