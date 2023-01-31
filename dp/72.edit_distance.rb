# https://leetcode.com/problems/edit-distance/

# Given two strings word1 and word2, return the minimum number of operations 
# required to convert word1 to word2.

# You have the following three operations permitted on a word:

# Insert a character
# Delete a character
# Replace a character

def min_distance(word1, word2)
  # base cases
  cache = Array.new(word1.length.succ) { Array.new(word2.length.succ, 0) }
  # fill base cases
  (0..word1.length).each { |r| cache[r][0] = r } # first row    0 -> n
  (1..word2.length).each { |c| cache[0][c] = c } # first column 0 -> n

  # populate dp table
  (1..word1.length).each do |r|
    (1..word2.length).each do |c|
      if word1[r.pred] == word2[c.pred]           # dp table vs string index
        cache[r][c] = cache[r.pred][c.pred]
      else
        cache[r][c] = [
          cache[r.pred][c],                       # Insert  (i,     j - 1)
          cache[r][c.pred],                       # Delete  (i - 1, j)
          cache[r.pred][c.pred]                   # Replace (i - 1, j - 1)
        ].min.succ                                # + 1
      end
    end
  end
  cache[word1.length][word2.length]
end

puts min_distance('acd', 'abd')
puts min_distance('acd', 'abd') == 1
# [
#         a  b  d
#    [0,| 1, 2, 3], 
#     ^ +---------         a  b  d
#  a [1,| 0, 0, 0],  ->  a 0, 1, 2 
#  c [2,| 0, 0, 0],  ->  b 1, 1, 2 
#  d [3,| 0, 0, 0]   ->  d 2, 2,>1<
# ]

puts min_distance('horse', 'ros')
puts min_distance('horse', 'ros') == 3
# [
#         r  o  s
#    [0,| 1, 2, 3], 
#     ^ +---------         r  o  s
#  h [1,| 0, 0, 0],  ->  h 1, 2, 3
#  o [2,| 0, 0, 0],  ->  o 2, 1, 2
#  r [3,| 0, 0, 0],  ->  r 2, 2, 2
#  s [4,| 0, 0, 0],  ->  s 3, 3, 2
#  e [5,| 0, 0, 0]   ->  e 4, 4,>3<
# ]

puts min_distance('intention', 'execution')
puts min_distance('intention', 'execution') == 5
# [
#         e  x  e  c  u  t  i  o  n
#    [0,| 1, 2, 3, 4, 5, 6, 7, 8, 9], 
#     ^ +---------------------------         e  x  e  c  u  t  i  o  n
#  i [1,| 0, 0, 0, 0, 0, 0, 0, 0, 0],  ->  i 1, 2, 3, 4, 5, 6, 6, 7, 8
#  n [2,| 0, 0, 0, 0, 0, 0, 0, 0, 0],  ->  n 2, 2, 3, 4, 5, 6, 7, 7, 7
#  t [3,| 0, 0, 0, 0, 0, 0, 0, 0, 0],  ->  t 3, 3, 3, 4, 5, 5, 6, 7, 8
#  e [4,| 0, 0, 0, 0, 0, 0, 0, 0, 0],  ->  e 3, 4, 3, 4, 5, 6, 6, 7, 8
#  n [5,| 0, 0, 0, 0, 0, 0, 0, 0, 0],  ->  n 4, 4, 4, 4, 5, 6, 7, 7, 7
#  t [6,| 0, 0, 0, 0, 0, 0, 0, 0, 0],  ->  t 5, 5, 5, 5, 5, 5, 6, 7, 8
#  i [7,| 0, 0, 0, 0, 0, 0, 0, 0, 0],  ->  i 6, 6, 6, 6, 6, 6, 5, 6, 7
#  o [8,| 0, 0, 0, 0, 0, 0, 0, 0, 0],  ->  o 7, 7, 7, 7, 7, 7, 6, 5, 6
#  n [9,| 0, 0, 0, 0, 0, 0, 0, 0, 0]   ->  n 8, 8, 8, 8, 8, 8, 7, 6,>5<
# ]
