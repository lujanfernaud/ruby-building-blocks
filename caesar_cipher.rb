def caesar_cipher(string, shift_factor)
  new_string      = ""
  character_bytes = (65..122).to_a

  string.each_byte do |character|
    new_character = if character_bytes.include?(character)
                      character_position      = character_bytes.index(character)
                      character_bytes_rotated = character_bytes.rotate(shift_factor)
                      character_bytes_rotated[character_position]
                    else
                      character
                    end
    new_string << new_character.chr
  end

  puts new_string
end

user_says = "yes"

while true
  if user_says == "yes"
    system "clear" or system "cls"
    puts "Please introduce some text:"
    user_text = gets.chomp

    puts "\n"
    puts "Please introduce the shift factor (Ex: 3):"
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
    puts "Hope you liked it!"
    break
  end
end
