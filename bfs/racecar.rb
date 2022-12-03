# https://leetcode.com/problems/race-car/

# Your car starts at position 0 and speed +1 on an infinite number line. Your car can go into negative positions. Your car drives automatically according to a sequence of instructions 'A' (accelerate) and 'R' (reverse):

# When you get an instruction 'A', your car does the following:
# position += speed
# speed *= 2
# When you get an instruction 'R', your car does the following:

# If your speed is positive then speed = -1
# otherwise speed = 1
# Your position stays the same.

# For example, after commands "AAR", your car goes to positions 0 --> 1 --> 3 --> 3, and your speed goes to 1 --> 2 --> 4 --> -1.

# Given a target position target, return the length of the shortest sequence of instructions to get there.

def racecar(destination)
  visited = []
  queue = [[0, 0, 1]] # moves, position, speed

  until queue.empty?
    moves, position, speed = queue.shift
    return moves if position == destination

    # skip if we alredy explored current location with same speed
    unless visited.include? [position, speed]
      visited << [position, speed]

      new_position = position + speed

      # exploration stage
      # 1. always advance
      queue << [moves.succ, new_position, speed * 2]

      # 2. explore if we also have to reverse direction
      positive_speed = speed > 0

      # do not reverse if in the next step we advannce and get closer to the destination (+ve speed)
      next if new_position < destination && positive_speed

      # do not reverse if in future location are get closer to the destination while going backwards (-ve speed)
      next if new_position > destination && !positive_speed

      queue << [moves.succ, position, positive_speed ? -1 : 1]
    end
  end
end

puts racecar(6)    == 5
puts racecar(5478) == 50
#---------

def racecar(destination)
  visited = []
  queue = [[0, 0, 1]] # moves, position, speed

  until queue.empty?
    moves, position, speed = queue.shift
    return moves if position == destination

    # skip if we alredy explored (current <location> with current <speed>)
    unless visited.include? [position, speed]
      visited << [position, speed]

      # exploration

      # 1. advance
      queue << [moves.succ, position + speed, speed * 2]

      # 2. reverse: change the direction of the car if

      # 2.1 The car is going to drive by the destination in the next move.
      if speed > 0 && position + speed > destination
        queue << [moves.succ, position, -1]
      end

      # 2.2 We are driving away from the destination. Reverse the reverse.
      if speed < 0 && position + speed < destination
        queue << [moves.succ, position, 1]
      end
    end
  end
end

puts racecar(5478) == 50
puts racecar(6) == 5
puts racecar(4) == 5
