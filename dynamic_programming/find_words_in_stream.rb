# // Input:
# // 1. magazine to cut out words from as list of words
# // 2. a message to reconstitute
# // 
# // Output: boolean whether it is possible to build the message from the magazine.

magazine = [
  'Ruby',
  'environment',
  'hello',
  'ready',
  'Everyone',
  'can',
  'toronto',
  'from',
  'Paris'
].map(&:downcase)

message = "Hello from Toronto".downcase.split

# O(number of words)
def preprocess_data(list_of_strings)
  {}.tap do |hash|
    list_of_strings.each do |word|
      hash[word] ||= 0             # initialize counter if not found
      hash[word] = hash[word].succ # increment count per word
    end
  end
end

# O(number of words in message + number of words in magazine)
def message_reconstruction_is_possible?(article, message)
  counters = preprocess_data(article)
  message.each do |word|
    word_count = counters[word]
    return false unless word_count
    if word_count.pred == 0
      counters.delete word
    else
      counters[word] = word_count.pred
    end
  end
  true
end

# return [boolean, list of matched words]
# O(number of words in message + number of words in magazine)
def message_reconstruction_is_possible_include_matches?(article, message)
  counters = preprocess_data(article)
  matches = message.select do |word|
    word_count = counters[word]
    next unless word_count
    if word_count.pred == 0
      counters.delete word
    else
      counters[word] = word_count.pred
    end
    true
  end
  [matches.count == message.count, matches]
end


puts message_reconstruction_is_possible?(magazine, message)
require 'pp'
PP.pp message_reconstruction_is_possible_include_matches?(magazine, message)

