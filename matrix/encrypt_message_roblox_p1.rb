# Roblox / Dec 15th, 2022 / part 1. 
# See follow up question (part 2): https://github.com/Kartoshka548/algos/tree/master/dynamic_programming/encrypt_message_roblox_p2.rb

# You and your friends are all fans of the hit TV show ThroneWorld and like to discuss it on social media. Unfortunately, some of your friends don't watch every new episode the minute it comes out. Out of consideration for them you would like to obfuscate your status updates so as to keep them spoiler-free.

# You settle on a route cipher, which is a type of transposition cipher. Given a message and a number of rows and number of columns, to compute the route encryption of the message:

#  - Write out the message row-wise in a grid of size rows by cols
#  - then read the message column-wise.

# You are guaranteed that rows * cols == len(message).

# Your task is to write a function that, given a message, rows, and cols, returns the route encryption of the message.

# Example:

rows1 = 6
cols1 = 6
message1 = "One does not simply walk into Mordor"

# O n e   d o
# e s   n o t
#   s i m p l
# y   w a l k
#   i n t o  
# M o r d o r

# Other examples:

rows2_1 = 5
cols2_1 = 3
message2 = "1.21 gigawatts!"
# 1 . 2
# 1   g
# i g a
# w a t
# t s !

# --------------------

# Time: O(rows * columns)
# Space: O(rows * columns)
def transpose(message, rows, cols)
  # matrix = []
  # rows.times do |r|
  #   matrix[r] = Array.new(cols)
  # end

  # matrix = Array.new(rows) { Array.new(cols) }
  matrix = (0..rows).map { Array.new(cols) }
  idx = 0

  # fill the matrix
  (0...rows).each do |r|
    (0...cols).each do |c|
      matrix[r][c] = message[idx]
      idx = idx.succ
    end
  end

  # read the matrix
  (0...cols).map do |c|
    (0...rows).map { |r| matrix[r][c] }.join
  end.join
end

puts transpose(message1, rows1, cols1) == "Oe y Mnss ioe iwnr nmatddoploootlk r"
puts transpose(message2, rows2_1, cols2_1) == "11iwt. gas2gat!"
puts transpose(message2, 3, 5) == "1ga.it2gt1as w!"
puts transpose(message2, 1, 15) == "1.21 gigawatts!"
puts transpose("M", 1, 1) == "M"
