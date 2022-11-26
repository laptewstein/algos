# https://leetcode.com/problems/koko-eating-bananas

def min_eating_speed(piles, h)
  return 1 if piles.count < 2 && piles.first < h

  l, r, min_speed = 0, piles.max, piles.max
  piles = piles.map(&:to_f)
  while l <= r
    speed = (l + r) / 2
    hours = piles.map { |pile| (pile.to_f / speed).ceil }.sum
    if hours > h
      l = speed.succ
    else
      min_speed = speed if speed < min_speed
      r = speed.pred
    end
  end
  min_speed
end

puts min_eating_speed([3, 6, 7, 11], 8)
puts min_eating_speed([30,11,23,4,20], 5)
puts min_eating_speed([30,11,23,4,20], 6)
puts min_eating_speed([312884470], 968709470)
