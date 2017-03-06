# Project: Caesar Cipher for The Odin Project
# Author: Luján Fernaud
#
# Instructions: Implement a caesar cipher that takes in a string and the shift factor
# and then outputs the modified string. Don't forget to keep the same case.

def caesar_cipher(string, shift_factor)
  new_string      = ""
  # Characters in range 65..90 are lowercase and in range 97..122 are uppercase.
  character_bytes = [(65..90).to_a, (97..122).to_a]

  string.each_byte do |character|
    # Select only the sub array that contains 'character' to keep the same case.
    character_array = character_bytes.select { |sub_array| sub_array.include?(character) }.flatten
    new_character   = if !character_array.empty?
                        character_position      = character_array.index(character)
                        character_array_rotated = character_array.rotate(shift_factor)
                        character_array_rotated[character_position]
                      # If the array is empty 'character' is not a letter.
                      else
                        character
                      end
    new_string << new_character.chr
  end

  puts new_string
end

user_says = "yes"

loop do
  if user_says == "yes"
    system "clear" or system "cls"
    puts "###################"
    puts "#                 #"
    puts "#  CAESAR CIPHER  #"
    puts "#                 #"
    puts "###################"
    puts "\n"
    puts "Please introduce some text:"
    user_text = gets.chomp

    puts "\n"
    puts "Please introduce the shift factor (for example, 3):"
    user_shift = gets.chomp.to_i

    puts "\n"
    puts "-" * user_text.length
    caesar_cipher(user_text, user_shift)
    puts "-" * user_text.length

    puts "\n"
    puts "Would you like to try again? (yes/no)"
    user_says = gets.chomp.downcase
  else
    system "clear" or system "cls"
    puts "Thanks for testing it. Hope you liked it!"
    puts "\n"
    break
  end
end
