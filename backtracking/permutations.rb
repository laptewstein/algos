# https://en.wikipedia.org/wiki/Heap's_algorithm

# Generate a list of permutations from the initial list of numbers
def permutations(nums)
  results = []
  last_index = nums.count.pred

  swap = lambda do |array, a, b|
    array[a], array[b] = array[b], array[a]
  end

  permutate = lambda do |array, start|
    for idx in start...array.size

      # change the candidate list for the following permutations
      swap.call(array, idx, start) unless idx == start

      if start == last_index
        results << Array.new(array)       # persist permutation
      else
        permutate.call(array, start.succ) # recurse
      end

      # backtrack so that we could try out other options
      swap.call(array, idx, start) unless idx == start
    end
  end

  permutate.call(nums, 0)
  results
end


# Permutation via Backtracking
# 
# Overview
# Generating permutations out of an array is one of the sub-problem that one would encounter in many scenarios. Therefore, it is an important and fun task to solve.
# 
# There are several classic algorithms to generate the permutations. For instance, B.R. Heap proposed an algorithm (named Heap’s algorithm) in 1963, which minimizes the movements of elements. It was still considered as the most efficient algorithm later in 1977.
# 
# Intuition
# It is based on the ideas of divide-and-conquer, swapping and backtracking.
# 
# First of all, the algorithm follows the paradigm of divide and conquer. Given an array `A[0:n]`, once we fix on the arrangements of the prefix subarray `A[0:i]`, we then reduce the problem down to a subproblem, i.e. generating the permutations for the postfix subarray `A[i:n]`.
# In order to fix on a prefix subarray, we apply the operation of swapping, where we swap the elements between a fixed position and an alternative position.
# 
# Finally, once we explore the permutations after a swapping operation, we then revert the choice (i.e. backtracking) by performing the same swapping, so that we could have a clean slate to start all over again.
# 
# Algorithm
# Now we can put together all the ideas that we presented before, and implement the permutation algorithm.
# 
# Here we implement the permutation algorithm as the function `permutate(array, start)` which generates the permutations for the postfix subarray of `array[start:len(array)]`.
# 
# Once we implement the function, we invocate it as `permutate(array, 0)` to generate all the permutations from the array. Here is a sample implementation in Python.
# 
# Algorithm to Generate Permutations
# As a preview, once implemented, the function will unfold itself as in the following example.
# 
# For instance, starting from the root node, first we try to fix on the first element in the final combination, which we try to switch the element between the first position in the array and each of the positions in the array. Since there are 3 possible candidates, we branch out in 3 directions from the root node.
# 
# The function can be implemented in recursion, due to its nature of divide-and-conquer and backtracking.
# 
# The base case of the function would be `start == array.size`, where we’ve fixed all the prefixes and reached the end of the combination. In this case, we simply add the current `array` as one of the results of combination.
# When we still have some postfix that need to be permutated, i.e. `start < array.size`, we then apply backtracking to try out all possible permutations for the postfixes, i.e. `permutate(array, start+1)`.

# More importantly, we need to swap the `start` element with each of the elements following the start index (including the start element). The goal is two-fold: 1). we generate different prefixes for the final combination; 2). we generate different lists of candidates in the postfixes, so that the permutations generated from the postfixes would vary as well.
# 
# At the end of backtracking, we will swap the `start` element back to its original position, so that we can try out other alternatives.

# Explained with print lines ######
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

