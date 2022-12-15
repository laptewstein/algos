# The median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value and the median is the mean of the two middle values.

# For example, for arr = `[1,3,99]`, the median is `3`.
# For example, for arr = `[2,3]`, the median is `(2 + 3) / 2 = 2.5`.


class MedianFinder
  def initialize
    @median = 0.0
    @list = []
  end

  def add_num(num)
    array = [num] + @list
    @list = array.sort # O(n * log n)
    if @list.count.even?
      index = @list.count / 2
      med = @list[index] + @list[index.pred]
      @median = med / 2.0
    else
      index = @list.count / 2
      @median = @list[index]
    end
    nil
  end

  def find_median
    @median
  end
end

median_finder = MedianFinder.new()

median_finder.add_num(1)                # arr = [1]
median_finder.add_num(2)                # arr = [1, 2]
puts median_finder.find_median() == 1.5 # (i.e., (1 + 2) / 2.0)

median_finder.add_num(3)                # arr[1, *2*, 3]
puts median_finder.find_median() == 2


# ========
require 'algorithms'

class MedianFinderUsingTwoHeaps
  def initialize
    @median = 0.0

    # max heap -> [1, 2, *3*] ... [*997*, 998, 999] < min heap
    # [1, 2, 3] [4, 5] -> add 2 -> [1, 2, 2] [3, 4, 5]
    @left, @right = Containers::MaxHeap.new, Containers::MinHeap.new
  end

  def add_num(num)
    if @left.empty?
      @left << num
      @median = @left.next
      return
    end
    
    if @left.next > num
      @right << @left.pop
      @left << num
    else
      @right << num
    end

    if [@left, @right].map(&:size).sum.even?
      @median = (@left.next + @right.next || 0) / 2.0
    else
      @median = @left.size < @right.size ? @right.next : @left.next
    end
    nil
  end

  def find_median
    @median
  end
end

median_finder = MedianFinderUsingTwoHeaps.new()
median_finder.add_num(1)                # left = [1]
median_finder.add_num(2)                # left = [1], right = [2]
puts median_finder.find_median() == 1.5 # (i.e., (1 + 2) / 2.0)
 
median_finder.add_num(3)                # left = [1], right = [*2*, 3]
puts median_finder.find_median() == 2

