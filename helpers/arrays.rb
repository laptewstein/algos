# generate 3 arrays of length 10 filled with random elements in -100..+100 range
# [[], [], []]
# [[23, 35, -64, 80, 77, 0, -49, 49, 90, 5], [-34, 30, 52, -95, -53, -2, 6, -19, 62, -53], [-37, 91, -27, -97, -78, 53, -93, -46, 26, 64]]
arrays = Array.new(3) { Array.new }
(0...arrays.count).each {|i| 10.times { arrays[i] << rand(-100..100) }}

# generate matrix of size 3 rows by 5 columns with nil values 
# [
#  [nil, nil, nil, nil, nil], 
#  [nil, nil, nil, nil, nil], 
#  [nil, nil, nil, nil, nil]
# ]
arrays = Array.new(3) { Array.new(5, nil) }

