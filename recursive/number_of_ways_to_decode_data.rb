def letter?(chars)
  chars.to_i < 27
end

# if a = 1, ... l = 11
def number_of_ways(pattern)
  count = 0
  return count if pattern.nil?      # base case
  return count if pattern[0] == '0' # base case
  return count if pattern == ""     # base case

  return 1 + number_of_ways(pattern[2..-1]) if letter?(pattern[0..1])
  number_of_ways(pattern[1..-1])
end

puts "for 12: #{number_of_ways('12')}"
puts "for 226: #{number_of_ways('226')}"
puts "for 06: #{number_of_ways('06')}"
puts "for 111: #{number_of_ways('111')}"


