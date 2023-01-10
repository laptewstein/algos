# https://leetcode.com/problems/max-points-on-a-line
# Max Points on a Line

# Given an array of points where points[i] = [xi, yi] represents a point on the X-Y plane, return the maximum number of points that lie on the same straight line.

def max_points(points)
  max = 1
  (0...points.size.pred).each do |idx|
    slopes = Hash.new(0)
    point_A_x, point_A_y = points[idx]
    (idx.succ...points.size).each do |idx_after|
      point_B_x, point_B_y = points[idx_after]
      slope =   "x:#{point_A_x}" if point_A_x == point_B_x
      slope ||= "y:#{point_A_y}"if point_A_y == point_B_y
      slope ||= (point_B_y - point_A_y).to_f / (point_B_x - point_A_x) # slope formula
      slopes[slope] += 1
    end
    # couunt points on the same line (same slope is shared between many points)
    # a line is between two points, and we inncrement counter for subsequent points
    local_max = slopes.values.max.succ
    max = local_max if local_max > max
  end
  max
end

# tests
puts max_points([[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]) = 4 # true
puts max_points([[1,1],[2,2],[3,3]]) == 3                  # true

