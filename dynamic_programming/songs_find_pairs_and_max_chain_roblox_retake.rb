=begin
We have a catalog of song titles (and their lengths) that we play at a local radio station.  We have been asked to play two of those songs in a row, and they must add up to exactly seven minutes long.  

Given a list of songs and their durations, write a function that returns the names of any two distinct songs that add up to exactly seven minutes.  If there is no such pair, return an empty collection. 
=end

song_times_1 = [
    ["Stairway to Heaven", "8:05"], 
    ["Immigrant Song", "2:27"],
    ["Rock and Roll", "3:41"], 
    ["Communication Breakdown", "2:29"],
    ["Good Times Bad Times", "2:48"], 
    ["Hot Dog", "3:19"],
    ["The Crunge", "3:18"], 
    ["Achilles Last Stand", "10:26"],
    ["Black Dog", "4:55"]
]
song_times_2 = [
    ["Stairway to Heaven", "8:05"], ["Immigrant Song", "2:27"],
    ["Rock and Roll", "3:41"], ["Communication Breakdown", "2:29"],
    ["Good Times Bad Times", "2:48"], ["Black Dog", "4:55"],
    ["The Crunge", "3:18"], ["Achilles Last Stand", "10:26"],
    ["The Ocean", "4:31"], ["Hot Dog", "3:19"],
]
song_times_3 = [
    ["Stairway to Heaven", "8:05"], ["Immigrant Song", "2:27"],
    ["Rock and Roll", "3:41"], ["Communication Breakdown", "2:29"],
    ["Hey Hey What Can I Do", "4:00"], ["Poor Tom", "3:00"],
    ["Black Dog", "4:55"]
]
song_times_4 = [
    ["Hey Hey What Can I Do", "4:00"], ["Rock and Roll", "3:41"], 
    ["Communication Breakdown", "2:29"], ["Going to California", "3:30"], 
    ["Black Mountain Side", "2:00"], ["Black Dog", "4:55"]
]  
song_times_5 = [["Celebration Day", "3:30"], ["Going to California", "3:30"]]

# S (2n)
# T O(n)
def findPair(song_list)
  limit_in_secs = 7 * 60
  songs = song_list.reject do |_, length| 
    duration = length.split(':')
    (duration.first.to_i * 60 + duration.last.to_i) > limit_in_secs
  end
  hash = {}
  matches = []
  songs.map do |name, duration|

    song_duration = duration.split(':')
    song_duration_in_seconds = song_duration.first.to_i * 60 + song_duration.last.to_i

    missing_length = limit_in_secs - song_duration_in_seconds
    matches << [name, hash[missing_length]] if hash[missing_length] 
    hash[song_duration_in_seconds] = name
  end
  matches.map { |match| puts "match: #{match.inspect}" }
end

puts findPair(song_times_1)
# => ["Hot Dog", "Rock and Roll"]
puts '-----'

puts findPair(song_times_2)
# => match: ["The Ocean", "Communication Breakdown"]
# => match: ["Hot Dog", "Rock and Roll"]
puts '-----'

puts findPair(song_times_3)
# => match: ["Poor Tom", "Hey Hey What Can I Do"]
puts '-----'

puts findPair(song_times_4)
puts '-----'

puts findPair(song_times_5)
# => match: ["Going to California", "Celebration Day"]
puts '-----'

# Alternative solution using duration (string keys) opposed to seconds (integer keys), and song list inversion istead of creating new song hash
def findPair(song_list)
  limit_in_secs = 7 * 60
  matches = []
  seen = []
  hash = song_list.to_h.invert
  song_list.each do |title, duration|
    seen << title
    minutes, seconds     = duration.split(':').map(&:to_i)
    remaining_seconds    = limit_in_secs - minutes * 60 - seconds
    second_song_duration = "#{remaining_seconds / 60}:%02i" % (remaining_seconds % 60)
    second_tune          = hash[second_song_duration]
    if second_tune
      matches << [title, second_tune] unless seen.include?(hash[second_song_duration])
    end
  end
  if matches.empty?
    "No matches"
  else
    matches.map { |match| puts "match: #{match.inspect}" }
  end
end

