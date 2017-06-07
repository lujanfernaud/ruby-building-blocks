# Project: Caesar Cipher for The Odin Project
# Author: Luján Fernaud
#
# Instructions: Implement a caesar cipher that takes in a string
# and the shift factor and then outputs the modified string.
# Don't forget to keep the same case.

def caesar_cipher(string, shift_factor)
  lowercase       = [*(65..90)]
  uppercase       = [*(97..122)]
  character_bytes = [lowercase, uppercase]
  new_string      = ""

  string.each_byte do |character|
    character_array = build_character_array(character_bytes, character)
    new_character = find_new_character(character_array, character, shift_factor)
    new_string << new_character.chr
  end

  new_string
end

# Select only the sub array that contains 'character' to keep the same case.
def build_character_array(character_bytes, character)
  character_bytes
    .select { |sub_array| sub_array.include?(character) }
    .flatten
end

def find_new_character(character_array, character, shift_factor)
  # If the array is empty then 'character' is not a letter.
  return character if character_array.empty?

  character_position      = character_array.index(character)
  character_array_rotated = character_array.rotate(shift_factor)
  character_array_rotated[character_position]
end

#
# Uncomment the following lines to play with it in the terminal.
#

# user_says = "yes"

# loop do
#   if user_says == "yes"
#     system "clear" or system "cls"
#     puts "###################"
#     puts "#                 #"
#     puts "#  CAESAR CIPHER  #"
#     puts "#                 #"
#     puts "###################"
#     puts "\n"
#     puts "Please introduce some text:"
#     user_text = gets.chomp

#     puts "\n"
#     puts "Please introduce the shift factor (for example, 3):"
#     user_shift = gets.chomp.to_i

#     puts "\n"
#     puts "-" * user_text.length
#     puts caesar_cipher(user_text, user_shift)
#     puts "-" * user_text.length

#     puts "\n"
#     puts "Would you like to try again? (yes/no)"
#     user_says = gets.chomp.downcase
#   else
#     system "clear" or system "cls"
#     puts "Thanks for testing it. Hope you liked it!"
#     puts "\n"
#     break
#   end
# end
