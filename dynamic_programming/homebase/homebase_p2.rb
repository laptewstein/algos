=begin
Suppose we have some input data describing a graph of relationships between parents and
children over multiple generations. The data is formatted as a list of (parent, child) pairs,
where each individual is assigned a unique positive integer identifier.

For example, in this diagram, 6 and 8 have common ancestors of 4 and 14.

               15
              / \
         14  13  21
         |   |
1   2    4   12
 \ /   / | \ /
  3   5  8  9
   \ / \     \
    6   7     11

pairs = [
    (1, 3), (2, 3), (3, 6), (5, 6), (5, 7), (4, 5),
    (15, 21), (4, 8), (4, 9), (9, 11), (14, 4), (13, 12),
    (12, 9), (15, 13)
]

Write a function that takes this data and the identifiers of two individuals as inputs
and returns true if and only if they share at least one ancestor.

Sample input and output:

hasCommonAncestor(pairs, 3, 8)   => false
hasCommonAncestor(pairs, 5, 8)   => true
hasCommonAncestor(pairs, 6, 8)   => true
hasCommonAncestor(pairs, 6, 9)   => true
hasCommonAncestor(pairs, 1, 3)   => false
hasCommonAncestor(pairs, 3, 1)   => false
hasCommonAncestor(pairs, 7, 11)  => true
hasCommonAncestor(pairs, 6, 5)   => true
hasCommonAncestor(pairs, 5, 6)   => true
hasCommonAncestor(pairs, 3, 6)   => true
hasCommonAncestor(pairs, 21, 11) => true

n: number of pairs in the input
=end

pairs = [
  [1, 3], [2, 3], [3, 6], [5, 6], [5, 7], [4, 5], [15, 21],
  [4, 8], [4, 9], [9, 11], [14, 4], [13, 12], [12, 9], [15, 13]
]


# return true if and only if they share at least one ancestor
# def hasCommonAncestor(pairs, a, b)
#   anchestors = {}
#   pairs.each do |p, c|
#     anchestors[c] ||= []
#     anchestors[c] << p
#   end
#   puts anchestors.inspect
#   anchestors_a = [a]
#   q = [a]
#   until q.empty?
#     item = q.pop
#     anchestors[item].each do |el|
#       anchestors_a << el
#       q << el
#     end
#   end
#   puts anchestors_a.uniq.inspect
#
#   anchestors_b = [b]
#   (anchestors_a & anchestors_b).empty? ? false : true
# end
#
# puts hasCommonAncestor(pairs, 3, 8).inspect


# def hasCommonAncestor(pairs, id1, id2)
#   # Create a hash to store the ancestors of each individual
#   ancestors = {}
#   # Iterate through the pairs
#   pairs.each do |parent, child|
#     # Add the parent as an ancestor of the child
#     ancestors[child] ||= []
#     ancestors[child] << parent
#   end
#   # Create a set to store the ancestors of the first individual
#   ancestors1 = Set.new([id1])
#   # Create a queue to store the individuals to visit
#   queue = [id1]
#   # Iterate through the queue
#   while !queue.empty?
#     # Get the next individual
#     current = queue.pop
#     # Add the ancestors of the current individual to the set
#     ancestors[current].each do |ancestor|
#       ancestors1.add(ancestor)
#       queue << ancestor
#     end
#   end
#   # Create a set to store the ancestors of the second individual
#   ancestors2 = Set.new([id2])
#   # Create a queue to store the individuals to visit
#   queue = [id2]
#   # Iterate through the queue
#   while !queue.empty?
#     # Get the next individual
#     current = queue.pop
#     # Add the ancestors of the current individual to the set
#     ancestors[current].each do |ancestor|
#       ancestors2.add(ancestor)
#       queue << ancestor
#     end
#   end
#   # Check if the two sets have any common elements
#   return !(ancestors1 & ancestors2).empty?
# end

# This function first creates a hash to store the ancestors of each individual.
#   Then it iterates through the input array of pairs and adds the parent
# as an ancestor of the child. After that, it creates two sets to store the ancestors
# of the first and second individuals. Then it iterates through the set of ancestors of
# the first individual and second individual, and for each individual, it adds the ancestors
# of the current individual to the set and adds the current individual to the queue.
# Finally, it check if the two sets have any common elements
#
# The time complexity of this function is O(n) where n is the number of pairs in the input.
# The space complexity of this function is O(n) as we are storing the ancestors of each
# individual in a hash and using queue and set to store the ancestors of the two individuals.
