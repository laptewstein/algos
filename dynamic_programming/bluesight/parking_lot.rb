# Design a Parking Lot tracker class
#
# This ParkingLot object should be able to provide us information about:
#   - how many spots are remaining
#   - how many total spots are in the parking lot
#   - when the parking lot is full
#   - when the parking lot is empty
#   - when certain spots are full e.g. when all motorcycle spots are taken
#   - how many spots vans are taking up
#
#
# Initalize new ParkingLot object with
#   - 100 regular parking spots
#   - 5 large (van) spots
#   - 10 dedicated motorcycle spots
#
#
# Add properties to the ParkingLot object so it would be possible to
#   - Register a new Vehicle park
#   - Register Vehicles leaving
#
# Then, lets simulate a situation that 7 vans, 8 motorcycles & 32 cars park in the lot
# And the last step, let's use the "leave parking" method we defined above to get to the state that the only vehicles remaining in the parking lot are 2 vans and 9 cars only.
# 
# Functional assumtpions:
#   a) Motorcycles can park at any spot when dedicated motorcycle spots are full
#   b) Vans can park in regualr spots when large dedicated spots are full, and they consume 3 regular spots

class ParkingLotException < StandardError; end

class ParkingLot
  attr_reader :regular_spots, :large_spots, :motorcycle_spots, :vans, :motorcycles, :cars

  def initialize(regular_spots: 0, large_spots: 0, motorcycle_spots: 0)
    @regular_spots    = regular_spots
    @large_spots      = large_spots
    @motorcycle_spots = motorcycle_spots
    @vans        = 0
    @motorcycles = 0
    @cars        = 0
  end

  def capacity()
    regular_spots + large_spots + motorcycle_spots
  end

  def car_spaces_used_by_other_vehicle_types(vehicle_type)
    case vehicle_type
    when :van
      dedicated = large_spots - vans
      dedicated < 0 ? dedicated.abs * 3 : 0
    when :motorcycle
      dedicated = motorcycle_spots - motorcycles
      dedicated < 0 ? dedicated.abs : 0
    end
  end

  def occupancy(vehicle_type = nil)
    case vehicle_type
    when :van
      resp = { vans: vans }
      if large_spots - vans < 0
        resp.merge(
          dedicated_spots: large_spots,
          car_spaces:      car_spaces_used_by_other_vehicle_types(vehicle_type))
      else
        resp.merge(dedicated_spots: vans)
      end
    when :motorcycle
      resp = { motorcycles: motorcycles }
      if motorcycle_spots - motorcycles < 0
        resp.merge(
          dedicated_spots: motorcycle_spots,
          car_spaces:      car_spaces_used_by_other_vehicle_types(vehicle_type))
       end
        resp.merge(dedicated_spots: motorcycles)
    else
      vans_in_car_spaces = car_spaces_used_by_other_vehicle_types(:van)
      motorcycles_in_car_spaces = car_spaces_used_by_other_vehicle_types(:motorcycle)
      { cars: cars }.tap do |h|
        h[:car_spaces_with_vans]        = vans_in_car_spaces        if vans_in_car_spaces > 0
        h[:car_spaces_with_motorcycles] = motorcycles_in_car_spaces if motorcycles_in_car_spaces > 0
      end
    end
  end

  def remaining_spots(vehicle_type = nil)
    case vehicle_type
    when :van
      available_spots = large_spots - vans
      available_spots > 0 ? available_spots + remaining_spots / 3 : remaining_spots / 3
    when :motorcycle
      available_spots = motorcycle_spots - motorcycles
      available_spots > 0 ? available_spots + remaining_spots : remaining_spots
    else
      other_vehicle_types = car_spaces_used_by_other_vehicle_types(:motorcycle)
      other_vehicle_types += car_spaces_used_by_other_vehicle_types(:van)
      regular_spots - cars - other_vehicle_types
    end
  end

  def fully_occupied?
    base_formula = capacity - motorcycles - cars # no van spaces
    dedicated_vans = large_spots - vans
    if dedicated_vans > -1
      base_formula - vans == 0
    else
      base_formula - large_spots - car_spaces_used_by_other_vehicle_types(:van) == 0
    end
  end

  def parking_available?(vehicle_type = nil)
    remaining_spots(vehicle_type) > 0
  end

  def empty?
    return false if cars > 0
    return false if vans > 0
    motorcycles == 0
  end

  def park_vehicle(vehicle_type = nil)
    case vehicle_type
    when :van
      @vans += 1        if parking_available?(vehicle_type)
    when :motorcycle
      @motorcycles += 1 if parking_available?(vehicle_type)
    else
      @cars += 1        if parking_available?(vehicle_type)
    end
  end

  def leave_vehicle(vehicle_type = nil)
    case vehicle_type
    when :van
      raise ParkingLotException if vans == 0
      @vans -= 1
    when :motorcycle
      raise ParkingLotException if motorcycles == 0
      @motorcycles -= 1
    else
      raise ParkingLotException if cars == 0
      @cars -= 1
    end
  end
end

parking_lot = ParkingLot.new(regular_spots: 100, large_spots: 5, motorcycle_spots: 10)

# 7 vans, 8 motorcycles & 32 cars park in the lot
7.times { parking_lot.park_vehicle(:van) }
8.times { parking_lot.park_vehicle(:motorcycle) }
33.times { parking_lot.park_vehicle }

parking_lot.occupancy
# {
#   :cars => 33,
#   :car_spaces_with_vans => 6
# }
parking_lot.occupancy :van
# {
#   :vans => 7,
#   :dedicated_spots => 5,
#   :car_spaces => 6
# }
parking_lot.occupancy :motorcycle
# {
#   :motorcycles => 8,
#   :dedicated_spots => 8
# }

parking_lot.capacity                               # 115
parking_lot.remaining_spots :van                   # 20
parking_lot.remaining_spots :motorcycle            # 63
parking_lot.remaining_spots :car                   # 61

parking_lot.fully_occupied?                        # false
60.times { parking_lot.park_vehicle }              # 60
3.times { parking_lot.park_vehicle(:motorcycle) }  # 3
parking_lot.fully_occupied?                        # true

parking_lot.cars                                   # 93
parking_lot.vans                                   # 7
parking_lot.motorcycles                            # 11

parking_lot.remaining_spots :van                   # 0
parking_lot.remaining_spots :motorcycle            # 0
parking_lot.remaining_spots :car                   # 0

parking_lot.leave_vehicle(:motorcycle) until parking_lot.motorcycles == 0
parking_lot.remaining_spots :motorcycle            # 11

parking_lot.leave_vehicle(:van) until parking_lot.vans == 0
parking_lot.remaining_spots :motorcycle            # 17

parking_lot.leave_vehicle until parking_lot.cars == 0
parking_lot.remaining_spots :motorcycle            # 110

parking_lot.remaining_spots                        # 100 (for cars)
parking_lot.capacity                               # 115
parking_lot.empty?                                 # true


# =============================
# Naive implementation (v1: no motorcycle or van parking in regular spots)
# class ParkingLotException < StandardError; end
# 
# class ParkingLot
#   attr_reader :regular_spots, :large_spots, :motorcycle_spots, :vans, :motorcycles, :cars
# 
#   def initialize(regular_spots: 0, large_spots: 0, motorcycle_spots: 0)
#     @regular_spots    = regular_spots
#     @large_spots      = large_spots
#     @motorcycle_spots = motorcycle_spots
#     @vans        = 0
#     @motorcycles = 0
#     @cars        = 0
#   end
# 
#   def capacity
#     regular_spots + large_spots + motorcycle_spots
#   end
# 
#   def remaining_spots(vehicle_type = nil)
#     case vehicle_type
#     when :van
#       large_spots - vans
#     when :motorcycle
#       motorcycle_spots - motorcycles
#     else
#       regular_spots - cars
#     end
#   end
# 
#   def fully_occupied?
#     capacity - vans - motorcycles - cars == 0
#   end
# 
#   def parking_available?(vehicle_type = nil)
#     remaining_spots(vehicle_type) > 0
#   end
# 
#   def empty?
#     remaining_spots == capacity
#   end
# 
#   def park_vehicle(vehicle_type = nil)
#     case vehicle_type
#     when :van
#       @vans += 1        if parking_available?(vehicle_type)
#     when :motorcycle
#       @motorcycles += 1 if parking_available?(vehicle_type)
#     else
#       @cars += 1        if parking_available?(vehicle_type)
#     end
#   end
# 
#   def leave_vehicle(vehicle_type = nil)
#     case vehicle_type
#     when :van
#       raise ParkingLotException if vans == 0
#       @vans -= 1
#     when :motorcycle
#       raise ParkingLotException if motorcycles == 0
#       @motorcycles -= 1
#     else
#       raise ParkingLotException if cars == 0
#       @cars -= 1
#     end
#   end
# end

parking_lot = ParkingLot.new(regular_spots: 100, large_spots: 5, motorcycle_spots: 10)

# 7 vans, 8 motorcycles & 32 cars park in the lot
7.times { parking_lot.park_vehicle(:van) }
8.times { parking_lot.park_vehicle(:motorcycle) }
32.times { parking_lot.park_vehicle }

# 2 vans, 9 cars  remaining in the parking lot
parking_lot.leave_vehicle(:motorcycle) until parking_lot.motorcycles == 0
parking_lot.leave_vehicle(:van) until parking_lot.vans == 2
parking_lot.leave_vehicle until parking_lot.cars == 9

