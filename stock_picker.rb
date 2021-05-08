# Importing the unit test library
require "test/unit/assertions"
include Test::Unit::Assertions

# [Array-of Number] -> [pair-of Number]
# Consumes an array of stock prices, one for each hypothetical day. It should 
# return a pair of days representing the best day to buy and the best day to 
# sell. Days start at 0.
def stock_picker(stock_array)
  # consumes the input_array and returns an [Array of [pair-of Numbers]] containing 
  # the delta value and the index of the max value
  delta_array = stock_array.each_with_index.map {|item, index| delta_checker(item, stock_array.drop(index), index)}

  # loop through the starting values and check where the minimum value for maximum 
  # delta is located
  maximum_delta = delta_array.each_with_index.max_by {|item, index| item[0]}

  #returns the index of minimum value and maximum value producing the maximum delta
  return [maximum_delta[1], maximum_delta[0][1]]
end

# Number [Array-of Number] Number -> [pair-of Numbers]
# Consumes a Number and an array of number and an index value and returns the maximum
# delta value between the value of the array and the number and the position of the 
# value in the array.
def delta_checker(compared_stock, checked_array, index)
  maximum_delta = checked_array.each_with_index.max
  # Returns a pair with in 0 position the delta between the max number and the 
  # compared_stock and in position 1 the total position of the max number
  return [maximum_delta[0] - compared_stock, maximum_delta[1] + index]
end

# Unit tests
assert_equal delta_checker(0, [17,3,6,9,15,8,6,1,10], 0), [17,0]
assert_equal delta_checker(12, [3,6,9,15,8,6,1,10], 3), [3,6]
assert_equal stock_picker([17,3,6,9,15,8,6,1,10]), [1,4]
