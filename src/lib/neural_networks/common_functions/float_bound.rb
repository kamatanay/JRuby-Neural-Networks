module CommonFunctions
  module FloatBound

    TOO_SMALL = -1.0E20

    TOO_BIG = 1.0E20

    def network_bound
      return TOO_SMALL if self < TOO_SMALL
      return TOO_BIG if self > TOO_BIG
      self
    end
  end
end
