# Given that we are looking to minimize the farthest distance we would have to walk,
# what block should we live in?

blocks = [{
  gym:      false, # 1
  school:   true,  # 0
  store:    false, # 4 # total score = 5; max to walk = 4
},
{
  gym:      true,  # 0
  school:   false, # 1
  store:    false, # 3 # total score = 4; max to walk = 3
},
{
  gym:      true,  # 0
  school:   true,  # 0
  store:    false, # 2 # total score = 2; max to walk = 2
},
{
  gym:      false, # 1 # total score = 2; max to walk = 1
  school:   true,  # 0
  store:    false, # 1
},
{
  gym:      false, # 1 # total score = 1; max to walk = 1
  school:   true,  # 0 # this is the one
  store:    true,  # 0
},
{
  gym:      true,  # 0 # total score = 1; max to walk = 1
  school:   false, # 1 # this is the one
  store:    true,  # 0
}
]
requirements = [:gym, :school, :store]

# returns [Integer] - the distance between relative and the first found indexes
def distance(blocks, requirement, relative_index, range_bound)
  upper_bound = relative_index + range_bound
  lower_bound = relative_index - range_bound
  if upper_bound < blocks.count
    return range_bound if blocks[upper_bound][requirement]
  end
  if lower_bound > -1
    return range_bound if blocks[lower_bound][requirement]
  end
  distance(blocks, requirement, relative_index, range_bound.succ)
end

# One pass - O(n) complexity
def minimize_farthest_distance(blocks, requirements)
  total_walk_score = blocks.count # total
  longest_walk     = blocks.count # for each requirement
  # more than one block with minimal walking distances may exist
  blocks_to_live   = []

  blocks.each_with_index do |block, index|
    # calculate minimum farthest distances for each requirement
    walk_scores = requirements.map { |req| distance(blocks, req, index, 0) }
    if walk_scores.sum < total_walk_score
      total_walk_score = walk_scores.sum
      blocks_to_live   = [ index ] # new lowest
      longest_walk     = walk_scores.max

    elsif walk_scores.sum == total_walk_score
      if walk_scores.max < longest_walk
        blocks_to_live = [ index ] # new lowest
        longest_walk   = walk_scores.max

      elsif walk_scores.max == longest_walk
        blocks_to_live << index    # equally good
      end
    end
  end
  puts "Blocks to live: #{blocks_to_live}; total walk score: #{total_walk_score}, longest_walk: #{longest_walk}"
  blocks_to_live
end

# flight
minimize_farthest_distance(blocks, requirements)
# Blocks to live: [4, 5]; total walk score: 1, longest_walk: 1
