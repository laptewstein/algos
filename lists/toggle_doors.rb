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

resp = flip_doors(DOORS)
puts resp

def flip_doorks(raw_doors)
    doors = raw_doors.clone
    # flip every n-th door
    (1..doors.count).each do |walk|
        # comb over door indexes and toggle n-th ones
        (0..(doors.count - 1)).step(walk).each do |idx|
            doors[idx] = !doors[idx]
        end
    end
    doors
end

resp2 = flip_doorks(DOORS)
puts resp2

puts "final #{resp == resp2}"