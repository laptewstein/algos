# (Leecode-134) https://leetcode.com/problems/gas-station/

# There are n gas stations along a circular route, where the amount of gas at the ith station is gas[i].

# You have a car with an unlimited gas tank and
# it costs cost[i] of gas to travel from the ith station
# to its next (i + 1)th station.

# You begin the journey with an empty tank at one of the gas stations.

# Given two integer arrays gas and cost, 
# return the starting gas station's index 
# if you can travel around the circuit once in the clockwise direction, otherwise return -1.
# If there exists a solution, it is guaranteed to be unique.

def can_complete_circuit?(gas_avail, distances)
  return -1 if gas_avail.sum < distances.sum

  remaining_gas, start_at = 0, 0
  for idx in 0...gas_avail.count do
    remaining_gas += gas_avail[idx] - distances[idx]
    if remaining_gas < 0
      remaining_gas = 0
      # we nominate the next index as the starting point
      # ONLY when we run out of gas
      start_at = idx.succ
    end
  end
  start_at
end

require 'rspec/autorun'
describe 'can_complete_circuit' do
  it 'should eval to possible' do
    gas  = [1, 2, 3, 4, 5]
    cost = [3, 4, 5, 1, 2]

    trip = can_complete_circuit?(gas, cost)
    expect(trip).to eq(3)
    puts "Drive away from index ##{trip}"
  end

  it 'should eval to possible x2' do
    gas  = [7, 1, 0, 11, 4]
    cost = [5, 9, 1, 2, 5]

    trip = can_complete_circuit?(gas, cost)
    expect(trip).to eq(3)
    puts "Drive away from index ##{trip}"
  end

  it 'should wait a day' do
    gas  = [2, 3, 4]
    cost = [3, 4, 3]

    expect(can_complete_circuit?(gas, cost)).to eq(-1)
    puts '¯\_(ツ)_/¯ Stay home!'
  end
end

