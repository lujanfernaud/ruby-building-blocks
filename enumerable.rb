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
    i = 0
    while i < size
      yield self[i]
      i += 1
    end
  end

  # 4. Create #my_each_with_index in the same way.
  def my_each_with_index
    i = 0
    while i < size
      yield self[i], i
      i += 1
    end
  end

  # 5. Create #my_select in the same way, though you may use #my_each in your
  # definition (but not #each).

  # 6. Create #my_all? (continue as above)

  # 7. Create #my_any?

  # 8. Create #my_none?

  # 9. Create #my_count

  # 10. Create #my_map

  # 11. Create #my_inject

  # 12. Test your #my_inject by creating a method called #multiply_els which
  # multiplies all the elements of the array together by using #my_inject,
  # e.g. multiply_els([2,4,5]) #=> 40

  # 13. Modify your #my_map method to take a proc instead.

  # 14. Modify your #my_map method to take either a proc or a block.
  # It won't be necessary to apply both a proc and a block in the same
  # #my_map call since you could get the same effect by chaining together
  # one #my_map call with the block and one with the proc. This approach is also
  # clearer, since the user doesn't have to remember whether the proc or block
  # will be run first. So if both a proc and a block are given, only execute
  # the proc.
end

array = [1, 3, 5, 6, 7, 9, 14, 21]

array.my_each { |n| puts "#{n}!" }
array.my_each_with_index { |n, i| puts "Number #{n} has index #{i}" }
