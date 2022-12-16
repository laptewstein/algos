# Roblox / Dec 15th, 2022 / part 2.
# See previous question (part 1): https://github.com/Kartoshka548/algos/tree/master/matrix/encrypt_message_roblox_p1.rb

# You decide to create a substitution cipher. The cipher alphabet is based on a key shared amongst those of your friends who don't mind spoilers.

# Suppose the key is:
# "The quick onyx goblin, Grabbing his sword ==}-------- jumps over the 1st lazy dwarf!". 

# We use only the unique letters in this key to set the order of the characters in the substitution table.

# T H E Q U I C K O N Y X G B L R A S W D J M P V Z F

# (spaces added for readability)

# We then align it with the regular alphabet:
# A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
# T H E Q U I C K O N Y X G B L R A S W D J M P V Z F

# Which gives us the substitution mapping: A becomes T, B becomes H, C becomes E, etc.

# Write a function that takes a key and a string and encrypts the string with the key.

# Complexity analysis:

# m: The length of the message
# k: The length of the key

# O(m + k)
def encrypt(msg, key)
  hash, seen, idx = {}, [], 0
  alphabet        = ('A'..'Z').to_a
  alphabet_count  = alphabet.count

  # 1) create a conversion table
  key.each_char do |char|
    # we have seen the entire alphabet, further iterations are futile
    break if idx == alphabet_count

    # ignore seen and non-alphabetic charaters
    upcase_char = char.upcase
    next if seen.include?(upcase_char) # hash.values
    next unless alphabet.include?(upcase_char)

    letter                = alphabet[idx]
    hash[letter]          = upcase_char
    hash[letter.downcase] = char.downcase

    seen << upcase_char
    idx = idx.succ
  end

  # 2) encrypt the message using the table above
  msg.each_char.map { |char| hash.fetch(char, char) }.join
end

key = "The quick onyx goblin, Grabbing his sword ==}-------- jumps over the 1st lazy dwarf!"

puts encrypt("It was all a dream.", key) == "Od ptw txx t qsutg."
puts encrypt("Would you kindly?", key) == "Pljxq zlj yobqxz?"

# {
#   "A" => "T", "a" => "t",
#   "B" => "H", "b" => "h",
#   "C" => "E", "c" => "e",
#   "D" => "Q", "d" => "q",
#   "E" => "U", "e" => "u",
#   "F" => "I", "f" => "i",
#   "G" => "C", "g" => "c",
#   "H" => "K", "h" => "k",
#   "I" => "O", "i" => "o",
#   "J" => "N", "j" => "n",
#   "K" => "Y", "k" => "y",
#   "L" => "X", "l" => "x",
#   "M" => "G", "m" => "g",
#   "N" => "B", "n" => "b",
#   "O" => "L", "o" => "l",
#   "P" => "R", "p" => "r",
#   "Q" => "A", "q" => "a",
#   "R" => "S", "r" => "s",
#   "S" => "W", "s" => "w",
#   "T" => "D", "t" => "d",
#   "U" => "J", "u" => "j",
#   "V" => "M", "v" => "m",
#   "W" => "P", "w" => "p",
#   "X" => "V", "x" => "v",
#   "Y" => "Z", "y" => "z",
#   "Z" => "F", "z" => "f"
# }

# I => O
# t => d
#   => 
# w => p
# a => t
# s => w
#   => 
# a => t
# l => x
# l => x
#   => 
# a => t
#   => 
# d => q
# r => s
# e => u
# a => t
# m => g
# . => 

