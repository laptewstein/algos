def square_root(number, precision = 8)
  root        = 0
  zero_count  = Math::log10(number).to_i # or .floor
  zero_count  -= 1 if zero_count.odd?
  denominator = 10 ** zero_count
  iteration   = number / denominator # first 1 or 2 leftmost digits of argument
  number      %= denominator

  # NIT: binary search?
  until (root.succ * root.succ) > iteration
    root += 1
  end

  remainder = iteration - (root * root)
  number    = (remainder * denominator) + (number % denominator)
  answer    = root

  solution_found = number == 0 && zero_count < 2
  dot, remaining_iterations = 1, precision

  until (number == 0 && solution_found) || remaining_iterations == 0
    zero_count -= 2 if zero_count > 1
    iteration = zero_count > 0 ? number / (10 ** zero_count) : number

    if number > 0 && (answer * 2 >= iteration)
      iteration               *= 100
      dot                     *= 0.1
      remaining_iterations    -= 1
    end

    last_digit = -1
    until (20 * answer + last_digit.succ) * last_digit.succ > iteration
      last_digit += 1
    end

    iteration -= (20 * answer + last_digit) * last_digit
    answer    = answer * 10 + last_digit

    number    = iteration * (10 ** zero_count) + number % (10 ** zero_count)
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
  100,
  4_00,
  3_40,
  16_00,
  2025,
  34_45,
  20250,
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
# Square root of 1600 is 40
# Square root of 2025 is 45
# Square root of 3445 is 58.69412236
# Square root of 20250 is 142.3024947
# Square root of 34567 is 185.92202666
# Square root of 345678 is 587.94387487
# Square root of 3456789 is 1859.24420128
# Square root of 2950771041 is 54321

