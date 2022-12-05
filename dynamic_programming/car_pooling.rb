# https://leetcode.com/problems/car-pooling/
# There is a car with capacity empty seats. The vehicle only drives east (i.e., it cannot turn around and drive west).

# You are given the integer capacity and an array trips where trips[i] = [numPassengersi, fromi, toi] indicates that the ith trip has numPassengersi passengers and the locations to pick them up and drop them off are fromi and toi respectively. The locations are given as the number of kilometers due east from the car's initial location.

# Return true if it is possible to pick up and drop off all passengers for all the given trips, or false otherwise.

# O(n)
# relative trip (shift duration) array (from first onboarding to last dropoff)
def car_pooling(trips, capacity)
  last_destination = trips.sort_by { |_, _, t| t }.last.last
  shift_start = trips.sort_by { |_, t, _| t }.first[1]
  shift = (shift_start..last_destination).to_a # [1, 2, 3, 4, 5, 6, 7]
  passenger_tracker = [0] * shift.size         # [0, 0, 0, 0, 0, 0, 0]

  trips.each do |trip|
  passengers, load, drop = trip
    # relative collection and dropoff indexes
    # special case: passengers can be dropped and picked up on the same stop
    # policy is to drop off before loading new passengers
    # do not reserve capacity on drop off indices
    ((load - shift_start)...(drop - shift_start)).each do |idx|
      passenger_tracker[idx] += passengers
      return false if passenger_tracker[idx] > capacity
  end
  true
end

# [1, 2, 3, 4, 5, 6, 7]
# [0, 0, 0, 0, 0, 0, 0]

puts car_pooling([[2, 1, 5],[3, 3, 7]], 4) == false
# [2, 0, 0, 0, 0, 0, 0]
# [2, 2, 0, 0, 0, 0, 0]
# [2, 2, 2, 0, 0, 0, 0]
# [2, 2, 2, 2, 0, 0, 0]
# [2, 2, 2, 2, 2, 0, 0]
# [2, 2, 5, 2, 0, 0, 0] -> false, 5 passengers exceed car capacity of 4

puts car_pooling([[2, 1, 5],[3, 3, 7]], 5) == true
# [2, 0, 0, 0, 0, 0, 0]
# [2, 2, 0, 0, 0, 0, 0]
# [2, 2, 2, 0, 0, 0, 0]
# [2, 2, 2, 2, 0, 0, 0]
# [2, 2, 2, 2, 2, 0, 0]
# [2, 2, 5, 2, 2, 0, 0]
# [2, 2, 5, 5, 2, 0, 0]
# [2, 2, 5, 5, 5, 0, 0]
# [2, 2, 5, 5, 3, 3, 0] -> true, 5 passengers can be taken at any time

puts car_pooling([[2, 1, 5], [3, 5, 7]], 3) == true
# [2, 0, 0, 0, 0, 0, 0]
# [2, 2, 0, 0, 0, 0, 0]
# [2, 2, 2, 0, 0, 0, 0]
# [2, 2, 2, 2, 0, 0, 0]
# [2, 2, 2, 2, 3, 0, 0]
# [2, 2, 2, 2, 3, 3, 0] -> true, at ndex 4 we drop off 2 and load 3 new clients 

# O(n * log n)
# using regular arrays to track actve trips
def car_pooling(trips, capacity)
  active_trips = []
  current_passengers = 0
  
  trips
    .sort_by { |_, origin, _| origin }
    .each do |passengers, origin, destination|
      # we are interested only in trips which end(ed/ing)
      # before or at the location where current trip starts
      ending_trips = active_trips.reject { |dest, _| dest > origin }

      unless ending_trips.empty?
        # update count of current passengers
        current_passengers -= ending_trips.map { |_, quantity| quantity }.sum

        # update trips in progress (remove completed a.k.a ended ones)
        active_trips -= ending_trips
      end

      current_passengers += passengers
      return false if current_passengers > capacity

      # keep track of trips in progress
      # (we track destination and how many passengers are traveling)
      active_trips << [destination, passengers]
    end
  true
end

puts car_pooling([[2, 1, 5], [3, 5, 7]], 3) == true
puts car_pooling([[2, 1, 5], [3, 3, 7]], 4) == false
puts car_pooling([[2, 1, 5],[3, 3, 7]], 5) == true

# O(n * log n)
# using a HEAP!
def car_pooling(trips, capacity)
  require 'algorithms'
  include Containers

  active_trips = MinHeap.new # sorted by earliest destination
  current_passengers = 0

  trips
    .sort_by { |_, origin, _| origin }
    .each do |passengers, origin, destination|

      # we are interested only in trips which end(ed/ing)
      # before or at the location where current trip starts
      until active_trips.empty? || active_trips.next.first > origin
        # discard completed trip and
        # update count of current passengers
        current_passengers -= active_trips.pop.last
      end

      current_passengers += passengers
      return false if current_passengers > capacity

      # keep track of trips in progress
      # (we track destination and how many passengers are traveling)
      active_trips << [destination, passengers]
    end
  true
end

puts car_pooling([[2, 1, 5], [3, 5, 7]], 3) == true
puts car_pooling([[2, 1, 5], [3, 3, 7]], 4) == false
puts car_pooling([[2, 1, 5],[3, 3, 7]], 5) == true

