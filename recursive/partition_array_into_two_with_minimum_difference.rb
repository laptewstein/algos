# Partition Array Into Two Arrays to Minimize Sum Difference

# def minimum_difference(list, idx = 0, partition = [], other_partition = [], partitions: false)
#   return [
#     [partition, other_partition]
#       .map(&:sum)
#       .reduce(:-)
#       .abs, 
#     partition, 
#     other_partition
#   ] if idx == list.size
#   # For every list elem at [idx], we have two choices:
#   # (+) We include it in the set
#   inc = minimum_difference(list, idx.succ, partition + [list[idx]], other_partition, partitions: true)
#   # (-) We do not include it in the set
#   exc = minimum_difference(list, idx.succ, partition, other_partition + [list[idx]], partitions: true)

#   # We return minimum of two choices
#   resp = inc.first < exc.first ? inc : exc # [a,b].min
#   partitions ? resp : resp.first
# end

# arr = [5, 10, 12, 15, 18, 20]
# puts minimum_difference(arr, partitions: true).inspect
# # [0, [10, 12, 18], [5, 15, 20]]

# arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
# puts minimum_difference(arr, partitions: true).inspect
# # [0, [15, 16, 17, 18, 19, 20], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]]

# # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].sum == 105
# # [15, 16, 17, 18, 19, 20].sum == 105

# arr = [-36, 36]
# puts minimum_difference(arr, partitions: true).inspect
# [0, [], [-36, 36]]


arr = [1, 6, 11, 5]





def findMinRec(arr, i, sumCalculated, sumTotal):

  # If we have reached last element.
  # Sum of one subset is sumCalculated,
  # sum of other subset is sumTotal-
  # sumCalculated.  Return absolute
  # difference of two sums.
  if (i == 0):
    return abs((sumTotal - sumCalculated) - sumCalculated)

  # For every item arr[i], we have two choices
  # (1) We do not include it first set
  # (2) We include it in first set
  # We return minimum of two choices
  return min(
    findMinRec(arr, i - 1, sumCalculated + arr[i - 1], sumTotal),
    findMinRec(arr, i - 1, sumCalculated, sumTotal)
  )

# Returns minimum possible
# difference between sums
# of two subsets


def findMin(arr,  n):

# Compute total sum
# of elements
sumTotal = 0
for i in range(n):
sumTotal += arr[i]

# Compute result using
# recursive function
return findMinRec(arr, n,
         0, sumTotal)


# Driver code
if __name__ == "__main__":

arr = [3, 1, 4, 2, 2, 1]
n = len(arr)
print("The minimum difference " +
"between two sets is ",
findMin(arr, n))