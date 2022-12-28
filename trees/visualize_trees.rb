# visualize a search tree
def pretty_print(serialized_tree, nil_value: 'N', separator: ",")
  # split 1D array ito n-D array, a tree with [root, [2 * child nodes], [4 * children] ...]
  split_array_into_levels = lambda do |node_values|
    tree, level = [], []
    level_idx     = tree.size
    level_members = 2 ** level_idx
    node_values.each do |node_value|
      level << node_value
      next unless level.size == level_members

      tree << level
      level          = []
      level_members *= 2
      level_idx     += 1
    end
    # dangling level, fill missing slots with nulls
    if level.size > 0
      level << nil until level.size == level_members
      tree << level
    end
    tree
  end

  cleansed_node_values = serialized_tree
  .split(separator)
  .map { |node_value| node_value.to_i unless node_value == nil_value } # integer or nil
  return unless cleansed_node_values.size > 0
  tree = split_array_into_levels.call(cleansed_node_values)
  
  # total space in the last level (max spacing of each node: 3)
  max_width = tree.last.length * 4

  # expects nD array, a tree with [root, [2 * child nodes], [4 * n]...]
  print_tree = lambda do |tree|
    tree.each_with_index do |subarray, level|
      indent = max_width / (2 ** level.succ)
      spacer = max_width / (2 ** level)
      subarray.each_with_index do |element, idx|
        element = "•" unless element
        printf("%*s", idx == 0 ? indent : spacer, element)
      end
      printf("\n")
    end
  end

  puts "_" * max_width
  print_tree[tree]
  puts "=" * max_width
  serialized_tree
end

puts pretty_print("5,2,6,1,4,N,8,N,N,3,N,N,N,7,9")
puts pretty_print("3,5,1,6,2,0,8,N,N,7,4") # auto-fills remaining nil values

# ________________________________
#                5
#        2               6
#    1       4       •       8
#  •   •   3   •   •   •   7   9
# ================================
# 5,2,6,1,4,N,8,N,N,3,N,N,N,7,9
# ________________________________
#                3
#        5               1
#    6       2       0       8
#  •   •   7   4   •   •   •   •
# ================================
# 3,5,1,6,2,0,8,N,N,7,4

unbalanced_tree = [65, 46, 73, 41, 53, nil, nil, 27, 43, 52, 54]
puts pretty_print(unbalanced_tree.map { |v| v || 'N' }.join(","))
# ________________________________
#               65
#       46              73
#   41      53       •       •
# 27  43  52  54   •   •   •   •
# ================================
# 65,46,73,41,53,N,N,27,43,52,54

unbalanced_bigger_tree = [41, 30, 55, 26, 32, 51, 69, nil, nil, nil, nil, 47, 52, 64, 72, nil, nil, nil, nil, nil, nil, nil, nil, 45, 48, nil, nil, nil, nil, nil, 76]
puts pretty_print(unbalanced_bigger_tree.map { |v| v || 'N' }.join(","))
# ________________________________________________________________
#                               41
#               30                              55
#       26              32              51              69
#    •       •       •       •      47      52      64      72
#  •   •   •   •   •   •   •   •  45  48   •   •   •   •   •  76
# ================================================================
# 41,30,55,26,32,51,69,N,N,N,N,47,52,64,72,N,N,N,N,N,N,N,N,45,48,N,N,N,N,N,76

