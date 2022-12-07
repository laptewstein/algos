# Write a method to sort an array in wave form,
# such that arr[0] > arr[1] < arr[2] > arr[3] < arr[4] > arr[5]

# Constraints:
#   There’s always at least one element in the list
#   No duplicates
#   List fits in memory
#   Order doesn’t matter as long as it satisfies the wave constraint
# I.e sortWavelist([11, 8, 6, 2, 10, 55]) => [11, 6, 8, 2, 55, 10]

# (-) O(n * log(n)) (Brute force: sort the array,
# then swap every EVEN element (n % 2) with the next (hungarian folk dance)


# (+) O(n): Rotate elements in place, space O(n)
def seesaw_sort(lst) # aka "wave sort"

  # Traverse ODD indices (1, 3, 5)
  (1...lst.count).step(2).each do |idx|

    # If current element is higher than previous, swap them. ( rule: X[0] > X[1] )
    lst[idx], lst[idx.pred] = lst[idx.pred], lst[idx] if lst[idx.pred] < lst[idx]

    next if idx.succ == lst.count # end of array, no next element

    # If current element is higher than next element, swap them. ( rule: X[1] < X[2] )
    lst[idx], lst[idx.succ] = lst[idx.succ], lst[idx] if lst[idx] > lst[idx.succ]
  end
  lst
end

for l in [[11, 8, 6, 2, 10, 55], [10, 5, 6, 3, 2, 20, 100, 80]]
  puts "#{l.inspect} => #{seesaw_sort(l).inspect}"
end

# [11, 8, 6, 2, 10, 55] => [11, 6, 8, 2, 55, 10]
# [10, 5, 6, 3, 2, 20, 100, 80] => [10, 5, 6, 2, 20, 3, 100, 80]
