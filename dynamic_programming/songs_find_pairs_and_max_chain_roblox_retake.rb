=begin
We have a catalog of song titles (and their lengths) that we play at a local radio station.  We have been asked to play two of those songs in a row, and they must add up to exactly seven minutes long.  

Given a list of songs and their durations, write a function that returns the names of any two distinct songs that add up to exactly seven minutes.  If there is no such pair, return an empty collection. 

Example:
song_times_1 = [
    ("Stairway to Heaven", "8:05"), ("Immigrant Song", "2:27"),
    ("Rock and Roll", "3:41"), ("Communication Breakdown", "2:29"),
    ("Good Times Bad Times", "2:48"), ("Hot Dog", "3:19"),
    ("The Crunge", "3:18"), ("Achilles Last Stand", "10:26"),
    ("Black Dog", "4:55")
]
find_pair(song_times_1) => ["Rock and Roll", "Hot Dog"] (3:41 + 3:19 = 7:00)

Additional Input:
song_times_2 = [
    ("Stairway to Heaven", "8:05"), ("Immigrant Song", "2:27"),
    ("Rock and Roll", "3:41"), ("Communication Breakdown", "2:29"),
    ("Good Times Bad Times", "2:48"), ("Black Dog", "4:55"),
    ("The Crunge", "3:18"), ("Achilles Last Stand", "10:26"),
    ("The Ocean", "4:31"), ("Hot Dog", "3:19"),
]
song_times_3 = [
    ("Stairway to Heaven", "8:05"), ("Immigrant Song", "2:27"),
    ("Rock and Roll", "3:41"), ("Communication Breakdown", "2:29"),
    ("Hey Hey What Can I Do", "4:00"), ("Poor Tom", "3:00"),
    ("Black Dog", "4:55")
]
song_times_4 = [
    ("Hey Hey What Can I Do", "4:00"), ("Rock and Roll", "3:41"),
    ("Communication Breakdown", "2:29"), ("Going to California", "3:30"),
    ("Black Mountain Side", "2:00"), ("Black Dog", "4:55")
]
song_times_5 = [("Celebration Day", "3:30"), ("Going to California", "3:30")]


Complexity Variable:
n = number of song/time pairs

All Test Cases - snake_case:
find_pair(song_times_1) => ["Rock and Roll", "Hot Dog"]
find_pair(song_times_2) => ["Rock and Roll", "Hot Dog"] or ["Communication Breakdown", "The Ocean"]
find_pair(song_times_3) => ["Hey Hey What Can I Do", "Poor Tom"]
find_pair(song_times_4) => []
find_pair(song_times_5) => ["Celebration Day", "Going to California"]

All Test Cases - camelCase:
findPair(songTimes1) => ["Rock and Roll", "Hot Dog"]
findPair(songTimes2) => ["Rock and Roll", "Hot Dog"] or ["Communication Breakdown", "The Ocean"]
findPair(songTimes3) => ["Hey Hey What Can I Do", "Poor Tom"]
findPair(songTimes4) => []
findPair(songTimes5) => ["Celebration Day", "Going to California"]

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
 matches.map {|match| puts "match: #{match.inspect}" }
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

# (2nd part) 
=begin
Our local radio station is running a show where the songs are ordered in a very specific way.  The last word of the title of one song must match the first word of the title of the next song - for example, "Silent Running" could be followed by "Running to Stand Still".  No song may be played more than once.

Given a list of songs and a starting song, find the longest chain of songs that begins with that song, and the last word of each song title matches the first word of the next one.  Write a function that returns the longest such chain. If multiple equivalent chains exist, return any of them.

Example:
songs1 = [
    "Down By the River",
    "River of Dreams",
    "Take me to the River",
    "Dreams",
    "Blues Hand Me Down",
    "Forever Young",
    "American Dreams",
    "All My Love",
    "Cantaloop",
    "Take it All",
    "Love is Forever",
    "Young American",
    "Every Breath You Take",
]
song1_1 = "Every Breath You Take"
chaining(songs1, song1_1) => ['Every Breath You Take', 'Take it All', 'All My Love', 'Love is Forever', 'Forever Young', 'Young American', 'American Dreams', 'Dreams']

Additional Input:
song1_2 = "Dreams"
song1_3 = "Blues Hand Me Down"
song1_4 = "Cantaloop"

songs2 = [
    "Bye Bye Love",
    "Nothing at All",
    "Money for Nothing",
    "Love Me Do",
    "Do You Feel Like We Do",
    "Bye Bye Bye",
    "Do You Believe in Magic",
    "Bye Bye Baby",
    "Baby Ride Easy",
    "Easy Money",
    "All Right Now",
]
song2_1 = "Bye Bye Bye"
song2_2 = "Bye Bye Love"

songs3 = [
    "Love Me Do",
    "Do You Believe In Magic",
    "Magic You Do",
    "Magic Man",
    "Man In The Mirror"
]
song3_1 = "Love Me Do"

All Test Cases:
chaining(songs1, song1_1) => ['Every Breath You Take', 'Take it All', 'All My Love', 'Love is Forever', 'Forever Young', 'Young American', 'American Dreams', 'Dreams']
chaining(songs1, song1_2) => ['Dreams']
chaining(songs1, song1_3) => ['Blues Hand Me Down', 'Down By the River', 'River of Dreams', 'Dreams']
chaining(songs1, song1_4) => ['Cantaloop']
chaining(songs2, song2_1) => ['Bye Bye Bye', 'Bye Bye Baby', 'Baby Ride Easy', 'Easy Money', 'Money for Nothing', 'Nothing at All', 'All Right Now']
chaining(songs2, song2_2) => ['Bye Bye Love', 'Love Me Do', 'Do You Feel Like We Do', 'Do You Believe in Magic']
chaining(songs3, song3_1) => ['Love Me Do', 'Do You Believe in Magic', 'Magic Man', 'Man In The Mirror']

Complexity Variable:
n = number of songs in the input

=end

songs1 = [
    "Down By the River",
    "River of Dreams",
    "Take me to the River",
    "Dreams",
    "Blues Hand Me Down",
    "Forever Young",
    "American Dreams",
    "All My Love",
    "Cantaloop",
    "Take it All",
    "Love is Forever",
    "Young American",
    "Every Breath You Take",
]

song1_1 = "Every Breath You Take"
song1_2 = "Dreams"
song1_3 = "Blues Hand Me Down"
song1_4 = "Cantaloop"

songs2 = [
    "Bye Bye Love",
    "Nothing at All",
    "Money for Nothing",
    "Love Me Do",
    "Do You Feel Like We Do",
    "Bye Bye Bye",
    "Do You Believe in Magic",
    "Bye Bye Baby",
    "Baby Ride Easy",
    "Easy Money",
    "All Right Now",
]
song2_1 = "Bye Bye Bye"
song2_2 = "Bye Bye Love"

songs3 = [
    "Love Me Do",
    "Do You Believe In Magic",
    "Magic You Do",
    "Magic Man",
    "Man In The Mirror"
]
song3_1 = "Love Me Do"

def chaining(songs, title, chain = [])
  chain = chain.clone << title
  last_word = title.split.last
  songs_starting_with_last_word = songs
    .reject { |song| song == title || chain.include?(song) }
    .select { |song| song.split.first == last_word }
  return chain if songs_starting_with_last_word.empty?
  
  songs_starting_with_last_word
    .map {|title| chaining(songs, title, chain) }
    .sort_by {|lst| lst.size }.last
end


puts chaining(songs1, song1_1) 
# => ['Every Breath You Take', 'Take it All', 'All My Love', 'Love is Forever', 'Forever Young', 'Young American', 'American Dreams', 'Dreams']
puts '------'

puts chaining(songs1, song1_2)
#  => ['Dreams']
puts '------'

puts chaining(songs1, song1_3)
# => ['Blues Hand Me Down', 'Down By the River', 'River of Dreams', 'Dreams']
puts '------'

puts chaining(songs1, song1_4)
#  => ['Cantaloop']
puts '------'

puts chaining(songs2, song2_1)
#  => ['Bye Bye Bye', 'Bye Bye Baby', 'Baby Ride Easy', 'Easy Money', 'Money for Nothing', 'Nothing at All', 'All Right Now']
puts '------'

puts chaining(songs2, song2_2)
#  => ['Bye Bye Love', 'Love Me Do', 'Do You Feel Like We Do', 'Do You Believe in Magic']
puts '------'

puts chaining(songs3, song3_1)
#  => ['Love Me Do', 'Do You Believe in Magic', 'Magic Man', 'Man In The Mirror']
puts '------'

