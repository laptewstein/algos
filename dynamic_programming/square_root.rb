# Newton-Raphson method

# The formula is derived from the equation 
# x^2 - n = 0
# which represents the equation for finding the square root of n. 
#
# The Newton-Raphson method involves finding the value of x that satisfies this equation by 
# starting with an initial guess and then iteratively improving the guess using the derivative of the equation. 
#
# In this case, the derivative of the equation is 2x, 
# and substituting it into the Newton-Raphson formula gives the formula shown above.

def my_sqrt(n_squared, precision = 8)
  root   = 1
  margin = root.to_f / (10 ** (precision / 2))
  root   = (root + n_squared / root) * 0.5 while (root - n_squared / root).abs > margin
  root.round(precision)
end

# testing
puts my_sqrt(34)
# while: 33.0
# new result: 9.721428571428572
# while: 15.557142857142857
# new result: 6.609428466463735
# while: 6.224000209929674
# new result: 5.876797445306567
# while: 1.4652620423143352
# new result: 5.831130717964241
# while: 0.09133345468465226
# new result: 5.830951897587282
# while: 0.00035764075391764294
# new result: 5.830951894845301
# 5.830951897587282

# binary search method
def square_root_binary_search(n, precision = 8, as_float: false)
  l, mid, r   = 0, n/2.0, n
  margin = 1.to_f / (10 ** precision)
  while r - l > margin
    power_two = mid ** 2
    if power_two > n
      r = mid
    else
      l = mid
    end
    mid = (l + r) / 2
  end
  as_float ? mid.round(precision) : mid.round(2).to_i 
end

puts square_root_binary_search(34, as_float: true)  # 5.83095189
puts square_root_binary_search(4)   		    # 2
puts square_root_binary_search(9)   		    # 3
puts square_root_binary_search(225) 		    # 15


# traditional method (split the number into pairs, find multipliers and subtract while shfting right)
def square_root(number, precision = 8)
  # if argument is float, find out          # of decimal points (for later use)
  decimal_places = 0
  decimal_number = number
  until decimal_number.to_i == decimal_number
    decimal_places += 1
    decimal_number *= 10
  end if number.is_a?(Float)

  root        = 0
  zero_count  = Math::log10(number).to_i    # or .floor
  zero_count  -= 1 if zero_count.odd?
  denominator = 10 ** zero_count
  iteration   = (number / denominator).to_i # first 1 or 2 leftmost digits of argument
  number      %= denominator

  # NIT: binary search?
  until (root.succ * root.succ) > iteration
    root += 1
  end

  remainder = iteration - (root * root)
  number    = (remainder * denominator) + (number % denominator).round(decimal_places)
  answer    = root

  solution_found = number == 0 && zero_count < 2
  dot, remaining_iterations = 1, precision

  until (number == 0 && solution_found) || remaining_iterations == 0
    zero_count -= 2 if zero_count > 1

    iteration = zero_count > 0 ? number / (10 ** zero_count) : number
    if number > 0 && (answer * 2 >= iteration.to_i)
      iteration               *= 100
      number                  *= 100
      dot                     *= 0.1
      remaining_iterations    -= 1
    end

    last_digit = -1
    until (20 * answer + last_digit.succ) * last_digit.succ > iteration
      last_digit += 1
    end

    remainder = iteration - (20 * answer + last_digit) * last_digit
    answer    = answer * 10 + last_digit

    number    = (remainder * (10 ** zero_count)).to_i + (number % (10 ** zero_count)).round(decimal_places)
    solution_found = true if number == 0
  end
  (answer * dot).round(precision)
end

# --------------
examples = [
  1,
  3,
  34,
  81,
  1_00,
  4_00,
  3_40,
  9_60.14, # decimal
  16_00,
  20_25,
  34_45,
  2_02_50,
  3_45_67,
  34_56_78,
  3_45_67_89,
  29_50_77_10_41
]

examples.each do |number|
  puts "Square root of #{number} is #{square_root(number)}"
end

# Square root of 1 is 1
# Square root of 3 is 1.7320508
# Square root of 34 is 5.83095189
# Square root of 81 is 9
# Square root of 100 is 10
# Square root of 400 is 20
# Square root of 340 is 18.43908891
# Square root of 960.14 is 30.98612592
# Square root of 1600 is 40
# Square root of 2025 is 45
# Square root of 3445 is 58.69412236
# Square root of 20250 is 142.3024947
# Square root of 34567 is 185.92202666
# Square root of 345678 is 587.94387487
# Square root of 3456789 is 1859.24420128
# Square root of 2950771041 is 54321


