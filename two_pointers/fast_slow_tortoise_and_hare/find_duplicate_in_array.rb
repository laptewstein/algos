# sum from 1..n: n * (n + 1) / 2
# integer_array = [1, 3, 3, 4, 2, 5]
# sum_of_ideal_array = integer_array.count * integer_array.count.succ / 2
# duplicate_element = integer_array.count - (sum_of_ideal_array - integer_array.reduce(&:+))

def find_duplicate(nums)
  # no duplicates found (n * (n + 1) / 2)
  return -1 if nums.count * nums.count.succ / 2 == nums.reduce(&:+)

  tortoise = nums[0]
  hare = nums[0]
  while true
    tortoise = nums[tortoise]
    hare = nums[nums[hare]]
    break if tortoise == hare
  end

  ptr1 = nums[0]
  ptr2 = tortoise
  while ptr1 != ptr2 do
    ptr1 = nums[ptr1]
    ptr2 = nums[ptr2]
  end
  ptr1
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
