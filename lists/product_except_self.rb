# Given an array nums of n integers where n > 1,
# return an array output such that output[i] is equal
# to the product of all the elements of nums except nums[i].

def product_except_self(integer_array)
  final_array             = []
  left_multiplied_result  = 1
  right_multiplied_result = 1

  (0...integer_array.length).each do |i|
    final_array[i]         = left_multiplied_result
    left_multiplied_result = left_multiplied_result * integer_array[i]
  end

  integer_array.length.pred.downto(0).each do |i|
    final_array[i]          = right_multiplied_result * final_array[i]
    right_multiplied_result = right_multiplied_result * integer_array[i]
  end
  final_array
end
sequence = [5, 2, 3, 4]
puts sequence.inspect
puts product_except_self(sequence).inspect

sequence = [5, 2, 3, 4,2,1,7]
puts sequence.inspect
puts product_except_self(sequence).inspect


