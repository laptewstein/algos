def traveling_salesmen(map)
  variants = []

  dfs = lambda do |current_vertex, visited, trip|
    # add starting point to visited
    visited += current_vertex

    if visited.size == map.keys.count
      # visited all vertices, go back home
      variants << [trip + map[current_vertex][visited[0]], visited + visited[0]]
    else
      map[current_vertex].keys.map do |destination|
        next if visited.index destination

        dfs.call(destination, visited, trip + map[current_vertex][destination])
      end
    end
  end

  # start from every possible vertex and make a full circle
  map.keys.each { |starting_point| dfs.call(starting_point, '', 0) }
  variants
    .group_by { |trip, _| trip }
    .sort_by  { |trip, _| trip }
end

graph = {
  'A' => { 'B' => 16, 'C' => 11, 'D' => 6 },
  'B' => { 'A' => 8,  'C' => 13, 'D' => 16 },
  'C' => { 'A' => 4,  'B' => 7,  'D' => 9 },
  'D' => { 'A' => 5,  'B' => 12, 'C' => 2 },
}

# same as the table:
# | * | A | B  |  C  | D   |
# |------------------------|
# | A | 0 | 16 |  11 |  6  |
# | B | 8 |  0 |  13 |  16 |
# | C | 4 |  7 |  0  |  9  |
# | D | 5 | 12 |  2  |  0  |

require 'pp'
PP.pp traveling_salesmen(graph)

# [
#  [23, [[23, "ADCBA"], [23, "BADCB"], [23, "CBADC"], [23, "DCBAD"]]], # any of these are shortest

#  [35, [[35, "ADBCA"], [35, "BCADB"], [35, "CADBC"], [35, "DBCAD"]]],
#  [38, [[38, "ABDCA"], [38, "BDCAB"], [38, "CABDC"], [38, "DCABD"]]],
#  [39, [[39, "ACBDA"], [39, "BDACB"], [39, "CBDAC"], [39, "DACBD"]]],
#  [40, [[40, "ACDBA"], [40, "BACDB"], [40, "CDBAC"], [40, "DBACD"]]],
#  [43, [[43, "ABCDA"], [43, "BCDAB"], [43, "CDABC"], [43, "DABCD"]]],
# ]
