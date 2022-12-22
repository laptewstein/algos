# select items based on Max Profit
# select items based on Min Weight
# BUT, the most efficent approach is: choose items based on (Profit / Weight) ratio (profit per unit of weight)

# Fractional knapsack
def fractional_knapsack(capacity, weights:, profits:)
  values = profits.zip(weights)
  idx = weights.count.pred

  profit_estimator = lambda do |conf|
    sum, cap, index = 0, capacity, idx
    until cap == 0 || index == -1
      if conf[index].last > cap
        sum += (conf[index].first.to_f / conf[index].last) * cap
        cap = 0
      else
        sum += conf[index].first
        cap -= conf[index].last
      end
      index = index.pred
    end
    sum
  end

  # select items based on Max Profit
  # take highest first
  max_profit = profit_estimator.call(values.sort_by { |profit, _| profit })

  # select items based on Min Weight
  # take lowest first
  min_weight = profit_estimator.call(values.sort_by { |_, weight| -1 * weight })

  # BUT, the most efficent approach is:
  # choose items based on (Profit / Weight) ratio (profit per unit of weight)
  # take highest first
  profit_to_weight = profit_estimator.call(values.sort_by { |profit, weight| profit.to_f / weight })

  [max_profit, min_weight, profit_to_weight]
end

weights = [1, 3,  5,  4, 1, 3, 2]
profits = [5, 10, 15, 7, 8, 9, 4]
puts fractional_knapsack(15, weights: weights, profits: profits)

