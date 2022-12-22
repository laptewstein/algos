# RESIDENTIAL THEFT (items can be taken only once, no repetition allowed)
# O(n * c) (use cache array)
def recursive_knapsack(capacity, volumes:, values:)
  dp_cache = Array.new(values.count) { Array.new(capacity.succ) } # use cache for intermediate results

  recurse = lambda do |idx, capacity_left| # idx: index of an item
    # base case
    return 0 if idx < 0 || capacity_left == 0
    return dp_cache[idx][capacity_left] if dp_cache[idx][capacity_left] # if we already have seen these numbers

    # if volume of the item at index <idx> exceeds capacity left,
    # then this item cannot be included
    return recurse.call(idx.pred, capacity_left) if volumes[idx] > capacity_left

    max_for_idx_and_capacity = [
      # exclude current item
      recurse.call(idx.pred, capacity_left),
      # include current item
      recurse.call(idx.pred, capacity_left - volumes[idx]) + values[idx]
    ].max

    # cache the result for internal access (use matrix a.k.a. "The Table")
    dp_cache[idx][capacity_left] = max_for_idx_and_capacity

    max_for_idx_and_capacity
  end
  recurse.call(values.count.pred, capacity)
end

# O(2^n) - no cache, slow!
# RESIDENTIAL THEFT (items can be taken only once, no repetition allowed)
def recursive_knapsack(capacity, volumes:, values:)
  recurse = lambda do |idx, capacity_left| # idx: index of an item
    # base case
    return 0 if idx < 0 || capacity_left == 0
    # if volume of the item at index <idx> exceeds capacity left,
    # then this item cannot be included
    return recurse.call(idx.pred, capacity_left) if volumes[idx] > capacity_left

    [
      # exclude current item
      recurse.call(idx.pred, capacity_left),
      # include current item
      recurse.call(idx.pred, capacity_left - volumes[idx]) + values[idx]
    ].max
  end
  recurse.call(values.count.pred, capacity)
end

values   = [60, 100, 120]
volumes  = [10, 20, 30]
capacity = 50
puts recursive_knapsack(capacity, volumes: volumes, values: values) # => 220

volumes  = [1, 2, 3, 4, 5]
values   = [5, 3, 5, 3, 2]
puts recursive_knapsack(4, volumes: volumes, values: values)        # => 10
puts recursive_knapsack(2, volumes: volumes, values: values)        # => 5

# ---------------

# STORE ROBBERY (items can be taken multiiple times, repetition IS allowed)
# O(3^n) - ideal for cache from above, impossibly slow the way it is out of the box
def recursive_knapsack(capacity, volumes:, values:)
  recurse = lambda do |idx, capacity_left| # idx: index of an item
    # base case
    return 0 if idx < 0 || capacity_left == 0
    # if volume of the item at index <idx> exceeds capacity left,
    # then this item cannot be included
    return recurse.call(idx.pred, capacity_left) if volumes[idx] > capacity_left

    [
      # exclude current item
      recurse.call(idx.pred, capacity_left),

      # include current item, (possibly grab a few more copies!)
      recurse.call(idx.pred, capacity_left - volumes[idx]) + values[idx],

      # include current item, and move on to next item
      recurse.call(idx, capacity_left - volumes[idx]) + values[idx]
    ].max
  end
  recurse.call(values.count.pred, capacity)
end

puts recursive_knapsack(4, volumes: volumes, values: values)        # => 20
puts recursive_knapsack(2, volumes: volumes, values: values)        # => 10

