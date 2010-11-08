module CommonFunctions

  module ArrayFunctions

    def map_to_hash(&block)
      empty_hash = {}
      self.inject(empty_hash) { |hash, array_item| hash.merge(build_hash_from array_item, block.call(array_item)) }
    end

    private
    def build_hash_from(key, value)
      { key => value }
    end

  end

end
