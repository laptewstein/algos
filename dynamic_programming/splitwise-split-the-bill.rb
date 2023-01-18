# https://www.hackerearth.com/practice/algorithms/graphs/graph-representation/practice-problems/algorithm/split-the-bill-3-5a0690ff/

# Shortest-Path Transfers: Shortest-path transfers lead to a reduction in the number of transfers.
#
# Specifically, for a group having multiple transactions, t
# he shortest-path transfers will be a list of payments to be made such that:
#
#   - Each payment can be represented by a list of the following form:
#     [payer_id, payee_id, amount].
#   - There is only 1 payer, and 1 payee in each payment, which are distinct from each other.
#     Each person (out of the N people) can only either be the payer (in all payments involving him), or the payee, but not both.
#   - The total amount of money that each person should receive/spend,
#     must be equal to the total amount he would receive/spend according to the given list of transactions.

# Clearly, there can be several shortest-path transfers for a particular list of transactions.
# Specifically, the lexicographically smallest shortest path has the following:
#
#   Arrange people who have borrowed money in ascending order of their IDs.
#   Do the same for people who have lent money.
#   Now, construct payments so that the least borrower ID has to pay the least lender ID.
#   Continue this process, till all debts have been settled.


# Given N members in a group, and lists representing the transactions(expenses),
# print the payments involved in the lexicographically smallest shortest-path transfers for the group.

def solve(friends, transaction_list)
  balancesheet = Array.new(friends, 0)

  transaction_list.each do |transaction|
    paid_by, split_as = ["paid_by", "split_as"].map { |k| transaction[k] }

    paid_by.each do |payer_id, amount_paid|
      balancesheet[payer_id.pred] -= amount_paid        # paid out of pocket
    end

    split_as.each do |consumer_id, amount_consumed|
      balancesheet[consumer_id.pred] += amount_consumed # someone might have covered this ^
    end
  end

  transfers  = []
  idx        = 0
  friend_idx = 0
  until idx == friends
    if balancesheet[idx] > 0
      until balancesheet[idx] == 0 # exhaust balance
        friend_idx += 1 until balancesheet[friend_idx] < 0
        if balancesheet[idx] + balancesheet[friend_idx] > 0
          transfer_amount          = -1 * balancesheet[friend_idx]
          balancesheet[idx]        += balancesheet[friend_idx]
          balancesheet[friend_idx] = 0
        else
          transfer_amount          = balancesheet[idx]
          balancesheet[friend_idx] += balancesheet[idx]
          balancesheet[idx]        = 0
        end
        transfers << [idx.succ, friend_idx.succ, transfer_amount]
      end
    end
    idx = idx.succ
  end
  transfers
end

# tests
# in an ideal world, payer ids should occupy 0..n-1 range
# but we're living in an imperfect simulation so we gotta adapt
transaction_list = [
  { "transaction_id" => "#a1234", "paid_by" => [[1, 60]], "split_as" => [[2, 60]] },
  { "transaction_id" => "#a2142", "paid_by" => [[2, 40]], "split_as" => [[3, 40]] },
  { "transaction_id" => "#b3310", "paid_by" => [[3, 30]], "split_as" => [[4, 30]] },
  { "transaction_id" => "#b2211", "paid_by" => [[4, 30]], "split_as" => [[3, 30]] },
  { "transaction_id" => "#f1210", "paid_by" => [[3, 20]], "split_as" => [[1, 20]] }
]
puts solve(4, transaction_list)
# [[2, 1, 20], [3, 1, 20]]

second_trip_transactions = [
  { "transaction_id" => "#a1234", "paid_by" => [[1, 25], [3, 15]], "split_as" => [[4, 10], [5, 25], [6, 5]] },
  { "transaction_id" => "#a2142", "paid_by" => [[4, 100]],         "split_as" => [[1, 25], [2, 25], [3, 25], [4, 25]] },
  { "transaction_id" => "#b3310", "paid_by" => [[3, 10], [5, 30]], "split_as" => [[1, 25], [4, 15]] },
  { "transaction_id" => "#b2211", "paid_by" => [[2, 150]],         "split_as" => [[1, 50], [2, 50], [3, 50]] },
  { "transaction_id" => "#f1210", "paid_by" => [[5, 13], [6, 25]], "split_as" => [[1, 13], [4, 25]] }
]
puts solve(6, second_trip_transactions)
# [[1, 2, 75], [1, 4, 13], [3, 4, 12], [3, 5, 18], [3, 6, 20]]


