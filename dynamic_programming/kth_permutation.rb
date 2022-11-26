# https://leetcode.com/problems/permutation-sequence/

def kth_permutation(n, k) # 4, 16
  permutation = []
  elements    = (1..n).to_a # [1, 2, 3, 4]

  # number of permutations for each position
  factorials  = [nil, 1] # undefined for less than 1 character
  (2..n).map do |idx|
    # if n > 1, figure out how many permutations exist
    factorials << idx * factorials[idx.pred]
  end

  k = k.pred # permutations begin at index #0
  until n == 0
    # use previous entry in factorials array if n > 1
    # otherwise divide current permutations by n
    part_length = factorials[n.pred] || factorials[n] / n
    part_idx = k / part_length

    # permutation starts with element at part_idx
    # discard element after detrermining its position in permutation
    permutation << elements.delete_at(part_idx)

    n = n.pred
    k %= part_length
  end
  permutation.join.to_i
end

puts kth_permutation(4, 16) == 3241
puts kth_permutation(3, 3)  == 213
puts kth_permutation(4, 9)  == 2314
puts kth_permutation(3, 1)  == 123

