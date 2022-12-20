=begin
Our local radio station is running a show where the songs are ordered in a very specific way.  The last word of the title of one song must match the first word of the title of the next song - for example, "Silent Running" could be followed by "Running to Stand Still".  No song may be played more than once.
Given a list of songs and a starting song, find the longest chain of songs that begins with that song, and the last word of each song title matches the first word of the next one.  Write a function that returns the longest such chain. If multiple equivalent chains exist, return any of them.
=end


def chaining(songs, title, chain = [])
  last_word = title.split.last
  repertoire = songs - [title]
  candidates = repertoire.select { |song| song =~ /^#{last_word}/ }
  return chain + [title] if candidates.empty?

  candidates
    .map     { |choice|   chaining(repertoire, choice, chain + [title]) }
    .sort_by { |playlist| playlist.length }.last
end

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

puts chaining(songs1, "Every Breath You Take") == ['Every Breath You Take', 'Take it All', 'All My Love', 'Love is Forever', 'Forever Young', 'Young American', 'American Dreams', 'Dreams']
puts chaining(songs1, "Dreams") == ['Dreams']
puts chaining(songs1, "Blues Hand Me Down") == ['Blues Hand Me Down', 'Down By the River', 'River of Dreams', 'Dreams']
puts chaining(songs1, "Cantaloop") == ['Cantaloop']

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

puts chaining(songs2, "Bye Bye Bye") == ['Bye Bye Bye', 'Bye Bye Baby', 'Baby Ride Easy', 'Easy Money', 'Money for Nothing', 'Nothing at All', 'All Right Now']

puts chaining(songs2, "Bye Bye Love") == ['Bye Bye Love', 'Love Me Do', 'Do You Feel Like We Do', 'Do You Believe in Magic']

songs3 = [
    "Love Me Do",
    "Do You Believe in Magic",
    "Magic You Do",
    "Magic Man",
    "Man In The Mirror"
]

puts chaining(songs3, "Love Me Do") == ['Love Me Do', 'Do You Believe in Magic', 'Magic Man', 'Man In The Mirror']

