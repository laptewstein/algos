# Partition Array Into Two Arrays to Minimize Sum Difference

def minimum_difference(list, idx = 0, partition = [], other_partition = [], partitions: false)
    # return [(partition.sum - other_partition.sum).abs, partition, other_partition] if idx == list.size
    return [[partition, other_partition].map(&:sum).reduce(:-).abs, partition, other_partition] if idx == list.size

  inc = minimum_difference(list, idx.succ, partition + [list[idx]], other_partition, partitions: true)
  exc = minimum_difference(list, idx.succ, partition, other_partition + [list[idx]], partitions: true)

  resp = inc.first < exc.first ? inc : exc # [a,b].min
  partitions ? resp : resp.first
end

arr = [5, 10, 12, 15, 18, 20]
puts minimum_difference(arr).inspect # => 0
puts minimum_difference(arr, partitions: true).inspect
# [0, [10, 12, 18], [5, 15, 20]]

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
puts minimum_difference(arr, partitions: true).inspect
# [0, [15, 16, 17, 18, 19, 20], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]]

# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].sum == 105
# [2] 3.1.1 > [15, 16, 17, 18, 19, 20].sum == 105

arr = [-36, 36]
puts minimum_difference(arr, partitions: true).inspect
# [0, [], [-36, 36]]

