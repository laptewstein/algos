# Floyd's https://en.wikipedia.org/wiki/Cycle_detection
# sum from 1..n: n * (n + 1) / 2
# integer_array = [1, 3, 3, 4, 2, 5]
# sum_of_ideal_array = integer_array.count * integer_array.count.succ / 2
# duplicate_element = integer_array.count - (sum_of_ideal_array - integer_array.reduce(&:+))

def find_duplicate(nums)
  # no duplicates found (n * (n + 1) / 2)
  return -1 if nums.count * nums.count.succ / 2 == nums.reduce(&:+)

  # advance pointers manually from index 0
  tortoise = nums[nums.first]
  hare     = nums[nums[nums.first]]

  # we are looking for the node (index) where fast and slow pointers converge
  until tortoise == hare
    tortoise = nums[tortoise]
    hare     = nums[nums[hare]]
  end

  # distance from beginning of the list to start of the loop (duplicate element)  
  # equals to the distance between where fast and slow pointers converged and the start of the loop.

  # We are going to iterate one more time over the array, this time with two slow (one step) pointers
  # starting at the begining of the array and the node (index) where slow and fast pointers converged.
  # When both point to the same node, it would mean we have found the duplicate element.
  snail = nums.first
  until tortoise == snail 
    snail    = nums[snail]
    tortoise = nums[tortoise]
  end
  tortoise
end

require 'rspec/autorun'
describe 'find_duplicate ' do
  it 'should find the duplicate' do
    expect(find_duplicate([3, 1, 3, 4, 2])).to eq 3
  end

  it 'should find the duplicate as well' do
    expect(find_duplicate([1, 3, 4, 4, 2, 5])).to eq 4
  end

  it 'should not find duplicates if there are none' do
    expect(find_duplicate([1, 3, 4, 6, 2, 5])).to eq -1
  end
end
