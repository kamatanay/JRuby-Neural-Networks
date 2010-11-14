class HopfieldTrainedNetwork

  def initialize weight_matrix
    @weight_matrix = weight_matrix
  end

  def present pattern
    pattern_in_doubles = Matrix.column_vector pattern.to_double
    pattern_found = (pattern_in_doubles.transpose*@weight_matrix).row(0).to_a
    pattern_found.to_bipolar
  end

end
