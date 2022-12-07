# There are 100 doors in a row, all doors are initially closed. 
# A person walks through all doors multiple times and toggle (if open then close, if close then open) them in the following way: 

#   In the first walk, the person toggles every door 
#   In the second walk, the person toggles every second door, i.e., 2nd, 4th, 6th, 8th, … 
#   In the third walk, the person toggles every third door, i.e. 3rd, 6th, 9th, … 
#   ...
#   In the 100th walk, the person toggles the 100th door. 

# Which doors are open in the end? 


DOORS = Array.new(100, false)

# flip every n-th door
def flip_doors(raw_doors)
  doors = raw_doors.clone
  # flip every n-th door
  (1..doors.count).each do |walk|
    # comb over door indexes and toggle n-th ones
    (0..(doors.count - 1)).each do |idx|
      doors[idx] = !doors[idx] if (idx % walk) == 0
    end
  end
  doors
end


def flip_windows(raw_windows)
  windows = raw_windows.clone
  # flip every n-th window
  (1..windows.count).each do |walk|
    # comb over window indexes and toggle n-th ones
    (0..(windows.count - 1)).step(walk).each do |idx|
      windows[idx] = !windows[idx]
    end
  end
  windows
end

WINDOWS = DOORS
puts flip_doors(DOORS) == flip_windows(WINDOWS) # true

