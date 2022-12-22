# Shuffle (reorder) list in place in O(n) time and O(1) space
# (modern) Fisher-Yates algorithm
def reorder(list)
  #
  list.count.pred.step(1, -1).each do |idx|
    # to exclude current index from random selection, multiply by idx
    # which in case of last index (1) will always evaluate to 0
    new_idx = (rand * idx.succ).floor

    # rand returns a float between 0 and 0.9999 inclusive;
    # we multiply the value by the number of remaining slots to assign (0 to idx)
    # and floor to the closest index.
    # 0---1---2---3---(4)
    list[idx], list[new_idx] = list[new_idx], list[idx]
  end
end

array = [1, 0, 3, 9, 2]
reorder(array)
puts array.inspect

# [1, 0, 3, 9, 2], idx 4 (val 2), swap with new idx 3 (val 9)
# [1, 0, 3, 2, 9], idx 3 (val 2), swap with new idx 3 (val 2)
# [1, 0, 3, 2, 9], idx 2 (val 3), swap with new idx 2 (val 3)
# [1, 0, 3, 2, 9], idx 1 (val 0), swap with new idx 0 (val 1)
# [0, 1, 3, 2, 9]

