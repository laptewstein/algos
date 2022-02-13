# We are a hacker trying to decrypt a digital lock.
# The digital lock consists of digits from 0-9.
# Luckily we know the exact digits in the passcode by looking at fingerprints on the lock.
# We also know the length of the passcode.
#
# Now we want to get the actual passcode with minimum tries.

# |1|2|3|
# |4|5|6|
# |7|8|9|
# |*|0|#|

# Assume we store the numbers in a set and we have a function check(passcode)
# to tell whether the passcode is correct or not.

# test case 1:
# fingerprints = [1, 2, 3, 4]
# password_length = 4
# answer = '3214'

# test case 2:
# seen = [1, 2, 3, 4], n=6
# answer = '332441'

def check(permutation, correct_answer)
  permutation if permutation == correct_answer
end

def password_generator(fingerprints, remaining_length, correct_answer, current_password = "")
  return check(current_password, correct_answer) if remaining_length == 0

  attempt = fingerprints.each do |fingerprint|
    base_case_test = password_generator(fingerprints, remaining_length.pred, correct_answer, "#{current_password}#{fingerprint}")
    break base_case_test if base_case_test
  end
  attempt if attempt.is_a?(String)
end

def guess_password(*args)
  results = password_generator(*args)
  puts results ? "Password have been found: #{results}" : "Password was not found"
end

puts guess_password([1, 2, 3], 3, '211')
puts guess_password([1, 2, 3, 4], 6, '332441')
