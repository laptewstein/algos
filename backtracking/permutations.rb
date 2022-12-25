#https://en.wikipedia.org/wiki/Heap's_algorithm

# def permutations(nums)
#   results = []
#   last_index = nums.count.pred

#   swap = lambda do |array, a, b|
#     array[a], array[b] = array[b], array[a]
#   end

#   permutate = lambda do |array, start|
#     for idx in start...array.size

#       # change the candidate list for the following permutations
#       swap.call(array, idx, start) unless idx == start

#       if start == last_index
#         results << Array.new(array)       # persist permutation
#       else
#         permutate.call(array, start.succ) # recurse
#       end

#       # backtrack so that we could try out other options
#       swap.call(array, idx, start) unless idx == start
#     end
#   end

#   permutate.call(nums, 0)
#   results
# end


# Generate a list of permutations from the initial list of numbers
def permutations(nums)
  results = []

  swap = lambda do |array, idx, start|
    array[idx], array[start] = array[start], array[idx]
    puts "Swapped! idx: #{idx}, start: #{start}, #{array.inspect}"
  end

  permutate = lambda do |array, start|

    # (0)...3, (1)...3, (2)...3
    for idx in start...array.size

      # change the candidate list for the following permutations
      unless idx == start
        puts "+" * start.succ + " (#{start}), " + "|" * idx + " [#{idx}] swap " + array.inspect
        swap.call(array, idx, start) # unless idx == start
        puts "=" * start.succ + " (#{start}), " + "|" * idx + " [#{idx}] swap complete " + array.inspect
      end

      if start == array.size.pred # (idx 2) == (3 - 1)
        puts "persist " + array.inspect
        # persist permutation
        results << Array.new(array)
      else
        # recurse
        puts "recursing from (#{start}) and idx [#{idx}] *Sending in: start (#{start.succ})"
        permutate.call(array, start.succ)
        puts "back from recursion to (#{start}) and idx [#{idx}]"
      end

      unless idx == start
        puts "-" * start.succ + " (#{start}), " + "|" * idx + " [#{idx}] UNswap " + array.inspect
        # backtrack so that we could try out other options
        swap.call(array, idx, start) # unless idx == start
        puts "=" * start.succ + " (#{start}), " + "|" * idx + " [#{idx}] UNswap complete " + array.inspect
      end
    end
    puts "! cycle is done. start was (#{start}) " + array.inspect
  end

  permutate.call(nums, 0)
  results
end

# Example
nums = [1, 2, 3]
puts permutations(nums).inspect
# results: [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]]

# recursing from (0) and idx [0] *Sending in: start (1)
# recursing from (1) and idx [1] *Sending in: start (2)
# persist [1, 2, 3]
# ! cycle is done. start was (2) [1, 2, 3]
# back from recursion to (1) and idx [1]
# ++ (1), || [2] swap [1, 2, 3]
# Swapped! idx: 2, start: 1, [1, 3, 2]
# == (1), || [2] swap complete [1, 3, 2]
# recursing from (1) and idx [2] *Sending in: start (2)
# persist [1, 3, 2]
# ! cycle is done. start was (2) [1, 3, 2]
# back from recursion to (1) and idx [2]
# -- (1), || [2] UNswap [1, 3, 2]
# Swapped! idx: 2, start: 1, [1, 2, 3]
# == (1), || [2] UNswap complete [1, 2, 3]
# ! cycle is done. start was (1) [1, 2, 3]
# back from recursion to (0) and idx [0]
# + (0), | [1] swap [1, 2, 3]
# Swapped! idx: 1, start: 0, [2, 1, 3]
# = (0), | [1] swap complete [2, 1, 3]
# recursing from (0) and idx [1] *Sending in: start (1)
# recursing from (1) and idx [1] *Sending in: start (2)
# persist [2, 1, 3]
# ! cycle is done. start was (2) [2, 1, 3]
# back from recursion to (1) and idx [1]
# ++ (1), || [2] swap [2, 1, 3]
# Swapped! idx: 2, start: 1, [2, 3, 1]
# == (1), || [2] swap complete [2, 3, 1]
# recursing from (1) and idx [2] *Sending in: start (2)
# persist [2, 3, 1]
# ! cycle is done. start was (2) [2, 3, 1]
# back from recursion to (1) and idx [2]
# -- (1), || [2] UNswap [2, 3, 1]
# Swapped! idx: 2, start: 1, [2, 1, 3]
# == (1), || [2] UNswap complete [2, 1, 3]
# ! cycle is done. start was (1) [2, 1, 3]
# back from recursion to (0) and idx [1]
# - (0), | [1] UNswap [2, 1, 3]
# Swapped! idx: 1, start: 0, [1, 2, 3]
# = (0), | [1] UNswap complete [1, 2, 3]
# + (0), || [2] swap [1, 2, 3]
# Swapped! idx: 2, start: 0, [3, 2, 1]
# = (0), || [2] swap complete [3, 2, 1]
# recursing from (0) and idx [2] *Sending in: start (1)
# recursing from (1) and idx [1] *Sending in: start (2)
# persist [3, 2, 1]
# ! cycle is done. start was (2) [3, 2, 1]
# back from recursion to (1) and idx [1]
# ++ (1), || [2] swap [3, 2, 1]
# Swapped! idx: 2, start: 1, [3, 1, 2]
# == (1), || [2] swap complete [3, 1, 2]
# recursing from (1) and idx [2] *Sending in: start (2)
# persist [3, 1, 2]
# ! cycle is done. start was (2) [3, 1, 2]
# back from recursion to (1) and idx [2]
# -- (1), || [2] UNswap [3, 1, 2]
# Swapped! idx: 2, start: 1, [3, 2, 1]
# == (1), || [2] UNswap complete [3, 2, 1]
# ! cycle is done. start was (1) [3, 2, 1]
# back from recursion to (0) and idx [2]
# - (0), || [2] UNswap [3, 2, 1]
# Swapped! idx: 2, start: 0, [1, 2, 3]
# = (0), || [2] UNswap complete [1, 2, 3]
# ! cycle is done. start was (0) [1, 2, 3]
# [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]]

