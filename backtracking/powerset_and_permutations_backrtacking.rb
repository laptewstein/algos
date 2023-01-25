# all possible combinations of elements including the []
def powerset(list)
  subset, result = [], [] # subset is a 'shared bus' across stack frames we add and pop out from
  dfs = lambda do |idx|
    return result << subset.clone if idx == list.size
    subset << list[idx]  # decision to include <element at current index>
    dfs[idx.succ]

    subset.pop           # backtrack: decision NOT to include <element at current index>
    dfs[idx.succ]        # (return to initial state) i.e [x] => []
  end
  dfs[0]
  result
end

puts powerset(%q(ABCD).split //).inspect
# [
#   ["A", "B", "C", "D"],
#   ["A", "B", "C"],
#   ["A", "B", "D"],
#   ["A", "B"],
#   ["A", "C", "D"],
#   ["A", "C"],
#   ["A", "D"],
#   ["A"],
#   ["B", "C", "D"],
#   ["B", "C"],
#   ["B", "D"],
#   ["B"],
#   ["C", "D"],
#   ["C"],
#   ["D"],
#   []
# ]

# all element permutations in different order
def permutations(list)
  result = []
  return [list.clone] if list.count == 1
  list.size.times do
    elem = list.shift       # pop from left (queue style)
    perms = permutations(list)
    result += perms.map { |permutation| permutation << elem }
    list << elem            # backtrack (append element)
  end
  result
end

puts permutations(%q(ABCD).split //).inspect
# [
#   ["D", "C", "B", "A"],
#   ["C", "D", "B", "A"],
#   ["B", "D", "C", "A"],
#   ["D", "B", "C", "A"],
#   ["C", "B", "D", "A"],
#   ["B", "C", "D", "A"],

#   ["A", "D", "C", "B"],
#   ["D", "A", "C", "B"],
#   ["C", "A", "D", "B"],
#   ["A", "C", "D", "B"],
#   ["D", "C", "A", "B"],
#   ["C", "D", "A", "B"],

#   ["B", "A", "D", "C"],
#   ["A", "B", "D", "C"],
#   ["D", "B", "A", "C"],
#   ["B", "D", "A", "C"],
#   ["A", "D", "B", "C"],
#   ["D", "A", "B", "C"],

#   ["C", "B", "A", "D"],
#   ["B", "C", "A", "D"],
#   ["A", "C", "B", "D"],
#   ["C", "A", "B", "D"],
#   ["B", "A", "C", "D"],
#   ["A", "B", "C", "D"]
# ]
#

# def permutations(list)
#   result = []
#   return [list.clone] if list.count == 1
#   list.size.times do
#     elem = list.shift       # pop from left (queue style)
#     puts "~~~ elem " + elem + ", list " + list.inspect
#     perms = permutations(list)
#     puts "||| list " + list.inspect + ", perms " + perms.inspect + "; elem: " + elem
#     result += perms.map { |permutation| permutation << elem }
#     list << elem            # backtrack (append element)
#     puts "=== list " + list.inspect + ", perms " + perms.inspect
#   end
#   result
# end
# puts permutations(%q(ABCD).split //).inspect

# ~~~ elem A, list ["B", "C", "D"]
#   ~~~ elem B, list ["C", "D"]
#     ~~~ elem C, list ["D"]
#     ||| list ["D"], perms [["D"]]; elem: C
#     === list ["D", "C"], perms [["D", "C"]]

#     ~~~ elem D, list ["C"]
#     ||| list ["C"], perms [["C"]]; elem: D
#     === list ["C", "D"], perms [["C", "D"]]

#   ||| list ["C", "D"], perms [["D", "C"], ["C", "D"]]; elem: B
#   === list ["C", "D", "B"], perms [["D", "C", "B"], ["C", "D", "B"]]
#     ~~~ elem C, list ["D", "B"]

#       ~~~ elem D, list ["B"]
#       ||| list ["B"], perms [["B"]]; elem: D
#       === list ["B", "D"], perms [["B", "D"]]

#       ~~~ elem B, list ["D"]
#       ||| list ["D"], perms [["D"]]; elem: B
#       === list ["D", "B"], perms [["D", "B"]]

#     ||| list ["D", "B"], perms [["B", "D"], ["D", "B"]]; elem: C
#     === list ["D", "B", "C"], perms [["B", "D", "C"], ["D", "B", "C"]]

#     ~~~ elem D, list ["B", "C"]
#       ~~~ elem B, list ["C"]

#       ||| list ["C"], perms [["C"]]; elem: B
#       === list ["C", "B"], perms [["C", "B"]]

#       ~~~ elem C, list ["B"]
#       ||| list ["B"], perms [["B"]]; elem: C
#       === list ["B", "C"], perms [["B", "C"]]
#     ||| list ["B", "C"], perms [["C", "B"], ["B", "C"]]; elem: D
#     === list ["B", "C", "D"], perms [["C", "B", "D"], ["B", "C", "D"]]

#   ||| list ["B", "C", "D"], perms [["D", "C", "B"], ["C", "D", "B"], ["B", "D", "C"], ["D", "B", "C"], ["C", "B", "D"], ["B", "C", "D"]]; elem: A
#   === list ["B", "C", "D", "A"], perms [["D", "C", "B", "A"], ["C", "D", "B", "A"], ["B", "D", "C", "A"], ["D", "B", "C", "A"], ["C", "B", "D", "A"], ["B", "C", "D", "A"]]
#     ~~~ elem B, list ["C", "D", "A"]

#       ~~~ elem C, list ["D", "A"]
#         ~~~ elem D, list ["A"]
#         ||| list ["A"], perms [["A"]]; elem: D
#         === list ["A", "D"], perms [["A", "D"]]
#         ~~~ elem A, list ["D"]
#         ||| list ["D"], perms [["D"]]; elem: A
#         === list ["D", "A"], perms [["D", "A"]]
#       ||| list ["D", "A"], perms [["A", "D"], ["D", "A"]]; elem: C
#       === list ["D", "A", "C"], perms [["A", "D", "C"], ["D", "A", "C"]]
#         ~~~ elem D, list ["A", "C"]
#           ~~~ elem A, list ["C"]
#           ||| list ["C"], perms [["C"]]; elem: A
#           === list ["C", "A"], perms [["C", "A"]]
#           ~~~ elem C, list ["A"]
#           ||| list ["A"], perms [["A"]]; elem: C
#           === list ["A", "C"], perms [["A", "C"]]
#         ||| list ["A", "C"], perms [["C", "A"], ["A", "C"]]; elem: D
#         === list ["A", "C", "D"], perms [["C", "A", "D"], ["A", "C", "D"]]

#         ~~~ elem A, list ["C", "D"]
#           ~~~ elem C, list ["D"]
#           ||| list ["D"], perms [["D"]]; elem: C
#           === list ["D", "C"], perms [["D", "C"]]
#           ~~~ elem D, list ["C"]
#           ||| list ["C"], perms [["C"]]; elem: D
#         === list ["C", "D"], perms [["C", "D"]]
#         ||| list ["C", "D"], perms [["D", "C"], ["C", "D"]]; elem: A
#         === list ["C", "D", "A"], perms [["D", "C", "A"], ["C", "D", "A"]]
#     ||| list ["C", "D", "A"], perms [["A", "D", "C"], ["D", "A", "C"], ["C", "A", "D"], ["A", "C", "D"], ["D", "C", "A"], ["C", "D", "A"]]; elem: B
#     === list ["C", "D", "A", "B"], perms [["A", "D", "C", "B"], ["D", "A", "C", "B"], ["C", "A", "D", "B"], ["A", "C", "D", "B"], ["D", "C", "A", "B"], ["C", "D", "A", "B"]]
# [...] below is unformatted [...]
# ~~~ elem C, list ["D", "A", "B"]
# ~~~ elem D, list ["A", "B"]
# ~~~ elem A, list ["B"]
# ||| list ["B"], perms [["B"]]; elem: A
# === list ["B", "A"], perms [["B", "A"]]
# ~~~ elem B, list ["A"]
# ||| list ["A"], perms [["A"]]; elem: B
# === list ["A", "B"], perms [["A", "B"]]
# ||| list ["A", "B"], perms [["B", "A"], ["A", "B"]]; elem: D
# === list ["A", "B", "D"], perms [["B", "A", "D"], ["A", "B", "D"]]
# ~~~ elem A, list ["B", "D"]
# ~~~ elem B, list ["D"]
# ||| list ["D"], perms [["D"]]; elem: B
# === list ["D", "B"], perms [["D", "B"]]
# ~~~ elem D, list ["B"]
# ||| list ["B"], perms [["B"]]; elem: D
# === list ["B", "D"], perms [["B", "D"]]
# ||| list ["B", "D"], perms [["D", "B"], ["B", "D"]]; elem: A
# === list ["B", "D", "A"], perms [["D", "B", "A"], ["B", "D", "A"]]
# ~~~ elem B, list ["D", "A"]
# ~~~ elem D, list ["A"]
# ||| list ["A"], perms [["A"]]; elem: D
# === list ["A", "D"], perms [["A", "D"]]
# ~~~ elem A, list ["D"]
# ||| list ["D"], perms [["D"]]; elem: A
# === list ["D", "A"], perms [["D", "A"]]
# ||| list ["D", "A"], perms [["A", "D"], ["D", "A"]]; elem: B
# === list ["D", "A", "B"], perms [["A", "D", "B"], ["D", "A", "B"]]
# ||| list ["D", "A", "B"], perms [["B", "A", "D"], ["A", "B", "D"], ["D", "B", "A"], ["B", "D", "A"], ["A", "D", "B"], ["D", "A", "B"]]; elem: C
# === list ["D", "A", "B", "C"], perms [["B", "A", "D", "C"], ["A", "B", "D", "C"], ["D", "B", "A", "C"], ["B", "D", "A", "C"], ["A", "D", "B", "C"], ["D", "A", "B", "C"]]
# ~~~ elem D, list ["A", "B", "C"]
# ~~~ elem A, list ["B", "C"]
# ~~~ elem B, list ["C"]
# ||| list ["C"], perms [["C"]]; elem: B
# === list ["C", "B"], perms [["C", "B"]]
# ~~~ elem C, list ["B"]
# ||| list ["B"], perms [["B"]]; elem: C
# === list ["B", "C"], perms [["B", "C"]]
# ||| list ["B", "C"], perms [["C", "B"], ["B", "C"]]; elem: A
# === list ["B", "C", "A"], perms [["C", "B", "A"], ["B", "C", "A"]]
# ~~~ elem B, list ["C", "A"]
# ~~~ elem C, list ["A"]
# ||| list ["A"], perms [["A"]]; elem: C
# === list ["A", "C"], perms [["A", "C"]]
# ~~~ elem A, list ["C"]
# ||| list ["C"], perms [["C"]]; elem: A
# === list ["C", "A"], perms [["C", "A"]]
# ||| list ["C", "A"], perms [["A", "C"], ["C", "A"]]; elem: B
# === list ["C", "A", "B"], perms [["A", "C", "B"], ["C", "A", "B"]]
# ~~~ elem C, list ["A", "B"]
# ~~~ elem A, list ["B"]
# ||| list ["B"], perms [["B"]]; elem: A
# === list ["B", "A"], perms [["B", "A"]]
# ~~~ elem B, list ["A"]
# ||| list ["A"], perms [["A"]]; elem: B
# === list ["A", "B"], perms [["A", "B"]]
# ||| list ["A", "B"], perms [["B", "A"], ["A", "B"]]; elem: C
# === list ["A", "B", "C"], perms [["B", "A", "C"], ["A", "B", "C"]]
# ||| list ["A", "B", "C"], perms [["C", "B", "A"], ["B", "C", "A"], ["A", "C", "B"], ["C", "A", "B"], ["B", "A", "C"], ["A", "B", "C"]]; elem: D
# === list ["A", "B", "C", "D"], perms [["C", "B", "A", "D"], ["B", "C", "A", "D"], ["A", "C", "B", "D"], ["C", "A", "B", "D"], ["B", "A", "C", "D"], ["A", "B", "C", "D"]]