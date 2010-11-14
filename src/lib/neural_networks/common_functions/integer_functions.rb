require 'matrix'
module CommonFunctions
  module IntegerFunctions

    def to_bit_pattern(number_of_bits)
      ( (0...number_of_bits).collect{|index| (self & 2**index) > 0 } )      
    end
    

  end
end
