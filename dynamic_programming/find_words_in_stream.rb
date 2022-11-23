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
def preprocess_string(magazine)
  {}.tap do |h|
    magazine.each do |word|
      h[word] ||= 0          # initialize counter if not found
      h[word] = h[word].succ # increment count per word
    end
  end
end

# O(num of words in message * number of words in magazine)
def message_reconstruction_is_possible?(article, message)
  counters = preprocess_string(article)
  message.select do |word|
    count = counters[word]
    next false unless counters[word]
    if count.pred == 0
      counters.delete word
      next true
    end
    counters[word] = count.pred
    true
  end.count == message.count
end

puts message_reconstruction_is_possible?(magazine, message)

