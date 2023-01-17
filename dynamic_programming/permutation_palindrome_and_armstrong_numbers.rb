# Write an efficient function that checks whether any permutation of an input string is a palindrome.
# You can assume the input string only contains lowercase letters.
#
# - "civic" should return **`True`**
# - "ivicc" should return **`True`**
# - "civil" should return **`False`**
# - "livci" should return **`False`**

def is_palindrome_permutation(s)
  # the idea is to end up with data structure
  # with no elements (even length) or one char having count of 1 (odd length)
  h = Hash.new(0)
  s.chars.each do |c|
    h[c] += 1 if c != ' ' # ignore whitespaces
  end
  odd_dict = h.reject { |_, v| v.even? }
  odd_dict.empty? || odd_dict.keys.count == 1
end


tests = [
  ["civic", true],
  ["ivicc", true],
  ["civil", false],
  ["livci", false],
  ['never odd or even', true]
]

tests.each do |s, r|
  resp = is_palindrome_permutation(s)
  puts "#{s}: #{resp}"
end


# An Armstrong number is an n-digit number that is equal to the sum of the nth powers of its digits.
# Determine if the input number is an Armstrong number. Return either true or false.
#
# 153 > Yes
# 1*1*1 + 5*5*5 + 3*3*3 = 153
#
# 1253 > No
# 1*1*1*1 + 2*2*2*2 + 5*5*5*5 + 3*3*3*3 = 723
def is_armstrong_number?(int)
  n   = "#{int}".length
  sum = 0
  denominator   = 10 ** n.pred if n > 2
  remaining_int = int
  remaining_n   = n
  until remaining_n == 0
    multiplier = (remaining_int / denominator)
    sum += (multiplier ** n)
    remaining_int -= (multiplier * denominator)
    puts [denominator, multiplier, sum, remaining_int].inspect
    denominator /= 10
    remaining_n = remaining_n.pred
  end

  sum == int
end

def is_armstrong_number?(num)
  num_str = num.to_s
  n       = num_str.length
  num_str.chars.map { |char| char.to_i ** n }.reduce(&:+) == num
end

puts is_armstrong_number?(9474)
puts is_armstrong_number?(9475)