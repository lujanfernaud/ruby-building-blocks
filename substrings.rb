# Project: Substrings for The Odin Project
# Author: Luján Fernaud
#
# Instructions: Implement a method #substrings that takes a word as the first
# argument and then an array of valid substrings (your dictionary) as the second
# argument. It should return a hash listing each substring (case insensitive)
# that was found in the original string and how many times it was found.

def substrings(string, dictionary)
  string_array = string.scan(/\w+/)
  hash = {}

  string_array.each do |word|
    dictionary.each do |w|
      next if word.downcase.scan(w).empty?
      hash.include?(w) ? hash[w] += 1 : hash[w] = 1
    end
  end

  sorted_hash = hash.sort_by { |_word, count| count }.reverse
  system "clear" or "cls"
  puts "Input: #{string}\n\n"
  puts "Matches:\n\n"
  sorted_hash.each { |word, count| puts "- #{word}: #{count}" }
  puts "\n"
end

dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i",
              "low", "own", "part", "partner", "sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)
