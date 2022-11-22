# Implement an algorithm to determine if a number(positive integer) is lucky.
#
# A lucky number is defined by the following process:
#   - Replace the number by the sum of the squares of its digits
#   - Repeat the process until the number equals 1 or we enter a cycle which does not include 1.
#   - Those numbers for which this process ends in 1 are lucky.
#
# E.g. 19 is a lucky number
# ---------------------------
# 19  --> 1^2 + 9^2 = 82
# 82  --> 8^2 + 2^2 = 68
# 68  --> 6^2 + 8^2 = 100
# 100 --> 1^2 + 0^2 + 0^2 = 1

def is_lucky(number)
 slow = number
 fast = number
 while true
   slow = square_of_number(slow)
   fast = square_of_number(square_of_number(fast))
   return true if fast == 1
   return false if fast == slow
 end
end
 
def square_of_number(num)
 sum = 0
 while num > 0
   last_digit = num % 10
   sum += last_digit * last_digit
   num = num / 10
 end
 sum
end
 
# Driver code
require 'pp'
PP.pp is_lucky(19) # Should print True
PP.pp is_lucky(61) # Should print False
 
