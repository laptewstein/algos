=begin
https://leetcode.com/problems/pascals-triangle

Given an integer numRows, return the first numRows of Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:
=end

def generate(num_rows)
  return [[1]] if num_rows == 1

  if num_rows == 2
    row = generate(num_rows.pred)
    return row << (row.last + [1])
  end

  # row 3 and above
  triangle = generate(num_rows.pred)
  bottom = triangle.last
  last_row = (1...bottom.count).map { |idx| bottom[idx.pred] + bottom[idx] }
  triangle << [1, *last_row, 1]
end

puts generate(1).inspect
puts generate(2).inspect
puts generate(3).inspect
puts generate(6).inspect

=begin
https://leetcode.com/problems/pascals-triangle-ii

119. Pascal's Triangle II
Given an integer rowIndex, return the rowIndexth (0-indexed) row of the Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:
=end

def get_row(row_index)
  return [1] if row_index == 0
  return [1, *get_row(row_index.pred)] if row_index == 1

  # row 2 and above
  previous_row = get_row(row_index.pred)
  last_row = (1...previous_row.count).map { |idx| previous_row[idx.pred] + previous_row[idx] }
  [1, *last_row, 1]
end

puts get_row(0).inspect
puts get_row(1).inspect
puts get_row(2).inspect
puts get_row(5).inspect

# [1]
# [1, 1]
# [1, 2, 1]
# [1, 5, 10, 10, 5, 1]

