# Partition Array Into Two Arrays to Minimize Sum Difference

def minimum_difference(list, idx = 0, partition = [], other_partition = [], partitions: false)
  return [(partition.sum - other_partition.sum).abs, partition, other_partition] if idx == list.size

  inc = findMinAbsDiff(list, idx.succ, partition + [list[idx]], other_partition, partitions: true)
  exc = findMinAbsDiff(list, idx.succ, partition, other_partition + [list[idx]], partitions: true)

  resp = inc.first < exc.first ? inc : exc 
  partitions ? resp : resp.first
end

arr = [5, 10, 12, 15, 18, 20]
puts findMinAbsDiff(arr).inspect # => 0
puts findMinAbsDiff(arr, partitions: true).inspect
# [0, [10, 12, 18], [5, 15, 20]]

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
puts findMinAbsDiff(arr, partitions: true).inspect
# [0, [15, 16, 17, 18, 19, 20], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]]

# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].sum == 105
# [2] 3.1.1 > [15, 16, 17, 18, 19, 20].sum == 105

