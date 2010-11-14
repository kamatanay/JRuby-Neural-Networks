require 'init'
require 'neural_networks/hopfield/hopfield_network'

BITS_PER_CHARACTER = 8
MAX_CHARACTERS_PER_NAME = 5
BITS_PER_NAME = MAX_CHARACTERS_PER_NAME * BITS_PER_CHARACTER

TRAINING_INPUTS = ["TINA ","ANTJE","LISA "]

def string_to_bit_pattern string
  number_array = string.chars.to_a.collect{|item| item[0] - " "[0] }
  number_array.collect{|value| value.to_bit_pattern(BITS_PER_CHARACTER)}.flatten
end

def bit_pattern_to_string pattern
  pattern_length = pattern.size
  total_number_of_characters = pattern_length/BITS_PER_CHARACTER
  total_bits_per_character = BITS_PER_CHARACTER
  bit_patterns_for_characters = (0...total_number_of_characters).collect{|index| pattern[index*total_bits_per_character...index*total_bits_per_character+total_bits_per_character] }
  code_array = bit_patterns_for_characters.collect{|bit_pattern| bit_pattern.integer_from_bit_pattern(total_bits_per_character){|value| value ? 1 : 0 }  }
  code_array.collect{|code| (code+" "[0]).chr }.join
end


training_input_bits = TRAINING_INPUTS.collect{|name| string_to_bit_pattern(name) }
network = HopfieldNetwork.trained_using(*training_input_bits)
p bit_pattern_to_string(network.present string_to_bit_pattern("TINE "))


