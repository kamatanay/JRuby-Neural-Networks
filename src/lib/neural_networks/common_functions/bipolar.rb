module CommonFunctions
  module Bipolar
    def to_double
      self.collect { | value | value ? 1 : -1 }  
    end

    def to_bipolar
      self.collect { | value | value > 0 }
    end
  end
end
