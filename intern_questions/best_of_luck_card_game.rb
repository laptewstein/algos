# Think about a card game called BestOfLuck.
# The rules of this two-player card game are simple:

# Each player is randomly given an equal number of cards.
# At each round, both of the players discard their cards, and the one with the more valuable card wins the round.
# If the discarded cards have the same value, the round is a tie.
# After all the cards are discarded by the players, the player who has more round wins, wins the game. The game may also be tied.
# Cards have this priority from the most valuable to the least valuable:
# A, K, Q, J, 10, 9, 8, 7, 6, 5, 4, 3, 2

# Fill up the solution(String[], String[]) method that calculates the winner of the game based on given String arrays that represents the chosen cards of Player A and Player B during the ended game respectively.
# Using the instructions above, the method should return;
# 1 if Player A has more win counts than Player B,
# 2 if Player B has more win counts than Player A,
# 0 if both players have the same win counts.

# Example:
# Suppose that we call the method as following:
# solution(new String[]{"A", "6", "J", "6"}, new String[]{"6", "6", "K", "Q"})

# Player A = [“A”, “6”, “J”, “6”]
# Player B = [“6”, “6”, “K”, “Q”]

#               Player A’s card | Player B’s | card Winner
# 1st Turn             A             6           A
# 2nd Turn             6             6         (DRAW)
# 3rd Turn             J             K           B
# 4th Turn             6             Q           B

# Explanation:
# Player A won 1st turn,
# Player B won 3rd and 4th turns,
# and the 2nd turn is a tie.
# Since Player B has more wins than Player A, the method should return 2.


def solution(player_1, player_2)
  score_a, score_b = 0, 0
  cards = ['A', 'K', 'Q', 'J', '10', '9', '8', '7', '6', '5', '4', '3', '2']
  (0...player_1.size).each do |idx|
    ind1 = cards.index(player_1[idx])
    ind2 = cards.index(player_2[idx])
    case ind1 <=> ind2
    when -1
      score_a += 1
    when 1
      score_b += 1
    end
  end
  res = score_a - score_b
  return res if res == 0
  res > 0 ? 1 : 2
end

puts solution(["A", "6", "J", "6"], ["6", "6", "K", "Q"])
