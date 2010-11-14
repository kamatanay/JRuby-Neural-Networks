module CommonFunctions

  module ArrayFunctions

    def map_to_hash(&block)
      empty_hash = {}
      self.inject(empty_hash) { |hash, array_item| hash.merge(build_hash_from array_item, block.call(array_item)) }
    end

    def integer_from_bit_pattern(number_of_bits,&block)
      (0...number_of_bits).to_a.inject(0){|sum,index| sum+(2**index)*block.call(self[index]) }
    end

    private
    def build_hash_from(key, value)
      { key => value }
    end

  end

end
