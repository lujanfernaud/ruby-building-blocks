def caesar_cipher(string, shift_factor)
  new_string = ""
  string.each_byte do |character|
    new_character = if character == 32 # An empty space.
                      character
                    else
                      character + shift_factor
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
