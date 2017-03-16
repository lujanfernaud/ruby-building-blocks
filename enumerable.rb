# Project: Enumerable Methods for The Odin Project
# Author: Luján Fernaud
#
# Instructions:
#
# 1. Create a script file to house your methods and run it in IRB
# to test them later.
#
# 2. Add your new methods onto the existing Enumerable module.

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
    to_a.my_each { |n| array << n if yield(n) }
    array
  end

  # 6. Create #my_all? (continue as above)
  def my_all?
    return my_all? { |n| n } unless block_given?
    array = []
    to_a.my_each { |n| array << n if yield(n) }
    array.size == size
  end

  # 7. Create #my_any?
  def my_any?
    return my_any? { |n| n } unless block_given?
    array = []
    to_a.my_each { |n| array << n if yield(n) }
    !array.empty?
  end

  # 8. Create #my_none?
  def my_none?
    return !my_any? { |n| yield(n) } if block_given?
    array = []
    to_a.my_each { |n| array << n if !!n == true }
    array.empty?
  end

  # 9. Create #my_count
  def my_count(item = false)
    return size if item == false && !block_given?
    array = []
    if item
      to_a.my_each { |n| array << n if n == item }
    else
      to_a.my_each { |n| array << n if yield(n) }
    end
    array.size
  end

  # 10. Create #my_map
  def my_map
    return to_enum unless block_given?
    array = []
    to_a.my_each { |n| array << yield(n) }
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
end

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

puts "------------------------"
puts "1. #my_each"
puts "------------------------\n"

puts "\np array.my_each"
p array.my_each { |n| "#{n}!" }
puts "\np array.each"
p array.each { |n| "#{n}!" }
puts "\narray.my_each (with puts in block)"
array.my_each { |n| puts "#{n}!" }
puts "\narray.each (with puts in block)"
array.each { |n| puts "#{n}!" }
puts "\np array.my_each (without block)"
p array.my_each
puts "\np array.each (without block)"
p array.each

puts "\n------------------------"
puts "2. #my_each_with_index"
puts "------------------------\n"

puts "\np array.my_each_with_index"
p array.my_each_with_index { |n, i| "Number #{n} has index #{i}" }
puts "\np array.each_with_index"
p array.each_with_index { |n, i| "Number #{n} has index #{i}" }
puts "\narray.my_each_with_index (with puts in block)"
array.my_each_with_index { |n, i| puts "Number #{n} has index #{i}" }
puts "\narray.each_with_index (with puts in block)"
array.each_with_index { |n, i| puts "Number #{n} has index #{i}" }
puts "\np array.my_each_with_index (without block)"
p array.my_each_with_index
puts "\np array.each_with_index (without block)"
p array.each_with_index

puts "\n------------------------"
puts "3. #my_select"
puts "------------------------\n"

puts "\np array.my_select(&:odd?)"
p array.my_select(&:odd?)
puts "\np array.select(&:odd?)"
p array.select(&:odd?)
puts "\narray.my_select (with puts in block)"
array.my_select { |n| puts n if n.odd? }
puts "\narray.select (with puts in block)"
array.select { |n| puts n if n.odd? }
puts "\np array.my_select (without block)"
p array.my_select
puts "\np array.select (without block)"
p array.select

puts "\n------------------------"
puts "4. #my_all?"
puts "------------------------\n"

puts "\np array.my_all? { |n| n < 9 }"
p array.my_all? { |n| n < 9 }
puts "\np array.all? { |n| n < 9 }"
p array.all? { |n| n < 9 }
puts "\np array.my_all? (without block)"
p array.my_all?
puts "\np array.all? (without block)"
p array.all?

puts "\n------------------------"
puts "5. #my_any?"
puts "------------------------\n"

puts "\np array.my_any? { |n| n < 9 }"
p array.my_any? { |n| n < 9 }
puts "\np array.any? { |n| n < 9 }"
p array.any? { |n| n < 9 }
puts "\np array.my_any? (without block)"
p array.my_any?
puts "\np array.any? (without block)"
p array.any?

puts "\n------------------------"
puts "6. #my_none?"
puts "------------------------\n"

puts "\np array.my_none? { |n| n < 9 }"
p array.my_none? { |n| n < 9 }
puts "\np array.none? { |n| n < 9 }"
p array.none? { |n| n < 9 }
puts "\np array.my_none? (without block)"
p array.my_none?
puts "\np array.none? (without block)"
p array.none?

puts "\n------------------------"
puts "7. #my_count"
puts "------------------------\n"

puts "\np array.my_count(3)"
p array.my_count(3)
puts "\np array.count(3)"
p array.count(3)
puts "\np array.my_count { |n| n < 9 }"
p array.my_count { |n| n < 9 }
puts "\np array.count { |n| n < 9 }"
p array.count { |n| n < 9 }
puts "\np array.my_count (without block)"
p array.my_count
puts "\np array.count (without block)"
p array.count

puts "\n------------------------"
puts "8. #my_map"
puts "------------------------\n"

puts "\np array.my_map { |n| n if n < 9 }"
p array.my_map { |n| n if n < 9 }
puts "\np array.map { |n| n if n < 9 }"
p array.map { |n| n if n < 9 }
puts "\np array.my_map (without block)"
p array.my_map
puts "\np array.map (without block)"
p array.map

proc = proc { |n| n if n > 9 }
puts "\nproc = proc { |n| n if n > 9 }"

puts "\narray.my_map(&proc)"
p array.my_map(&proc)
puts "\narray.map(&proc)"
p array.map(&proc)

puts "\n------------------------"
puts "9. #my_inject"
puts "------------------------\n"

puts "\np array.my_inject { |sum, n| sum + n }"
p array.my_inject { |sum, n| sum + n }
puts "\np array.inject { |sum, n| sum + n }"
p array.inject { |sum, n| sum + n }
puts "\np array.my_inject(9) { |sum, n| sum + n }"
p array.my_inject(9) { |sum, n| sum + n }
puts "\np array.inject(9) { |sum, n| sum + n }"
p array.inject(9) { |sum, n| sum + n }
puts "\np array.my_inject(:*)"
p array.my_inject(:*)
puts "\np array.inject(:*)"
p array.inject(:*)
puts "\np array.my_inject(3, :*)"
p array.my_inject(3, :*)
puts "\np array.inject(3, :*)"
p array.inject(3, :*)
puts "\np array.my_inject('<<')"
p array.my_inject("<<")
puts "\np array.inject('<<')"
p array.inject("<<")

puts "\n------------------------"
puts "10. #multiply_els"
puts "------------------------\n"

puts "\np array.multiply_els"
p array.multiply_els
puts "\np multiply_els([2, 4, 5])"
p multiply_els([2, 4, 5])
puts "\n"
