# Project: Substrings for The Odin Project
# Author: Luján Fernaud
#
# Instructions: Implement a method #substrings that takes a word as the first
# argument and then an array of valid substrings (your dictionary) as the second
# argument. It should return a hash listing each substring (case insensitive)
# that was found in the original string and how many times it was found.

def substrings(word, dictionary)
  hash = {}

  dictionary.each do |w|
    next if word.scan(w).empty?
    if hash.include?(w)
      hash[w] += 1
    else
      hash[w] = 1
    end
  end

  puts hash
end

dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i",
              "low", "own", "part", "partner", "sit"]

substrings("below", dictionary)
