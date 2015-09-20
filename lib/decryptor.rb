require 'date'
require './lib/encryptor'
require './lib/message_decryptor'
require 'pry'

class Decrypt
  attr_accessor :key, :offsets, :key_a, :key_b, :key_c, :key_d

  def initialize
    input_key = ARGV[2]
    @key      = input_key.split""
    @offsets  = Offsets.new.offsets_array
  end

  def key_a
    key_a_string = @key[0] + @key[1]
    @key_a = key_a_string.to_i
  end

  def key_b
    key_a_string = @key[1] + @key[2]
    @key_b = key_a_string.to_i
  end

  def key_c
    key_a_string = @key[2] + @key[3]
    @key_c = key_a_string.to_i
  end

  def key_d
    key_a_string = @key[3] + @key[4]
    @key_d = key_a_string.to_i
  end

  def key_array
    @key_array = []
    @key_array.insert(0, key_a)
    @key_array.insert(1, key_b)
    @key_array.insert(2, key_c)
    @key_array.insert(3, key_d)
    @key_array
  end

  def offsets_a
    @offsets_a = @offsets[0]
  end

  def offsets_b
    @offsets_b = @offsets[1]
  end

  def offsets_c
    @offsets_c = @offsets[2]
  end

  def offsets_d
    @offsets_d = @offsets[3]
  end

  def rotation
    @rotation = []
    @rotation.insert(0, key_a + offsets_a)
    @rotation.insert(1, key_b + offsets_b)
    @rotation.insert(2, key_c + offsets_c)
    @rotation.insert(3, key_d + offsets_d)
    @rotation
  end
end

# class MessageDecrypt
#
#   def decryptor(message, rotation)
#     character_map = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
#                     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y','z',
#                     '0', '1', '2', '3', '4', '5', '6', '7','8','9', ' ', '.', ',']
#     array = []
#     counter = 0
#     message.map do |letter|
#       if !character_map.include?(letter)
#         array << letter
#       else
#         pos_char_map = character_map.index(letter)
#         array  <<   character_map[(pos_char_map - rotation[counter]) % character_map.length]
#         counter = (counter + 1) % rotation.length
#       end
#     end
#     array
#   end
# end

input_file = ARGV[0]
output_file = ARGV[1]
key = ARGV[2]
date = ARGV[3]
message = File.read(input_file).chomp.downcase.gsub(/["\n"]/, " ").chars
temp = Decrypt.new
rotation = temp.rotation
decrypted_chars = MessageDecrypt.new.decryptor(message, rotation)
decrypted_message = decrypted_chars.join
File.open(output_file, "w") { |file| file.write(decrypted_message)}

puts "Created #{output_file} with the key #{key} and date #{date}"
