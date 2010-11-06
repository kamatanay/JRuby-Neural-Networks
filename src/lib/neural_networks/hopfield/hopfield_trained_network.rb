class HopfieldTrainedNetwork

  def initialize weight_matrix
    @weight_matrix = weight_matrix
  end

  def present pattern
    pattern_in_doubles = Matrix.column_vector pattern.to_double
    row_matrix_array = @weight_matrix.row_vectors.collect{ |vector| Matrix[vector.to_a] }
    pattern_found = row_matrix_array.collect{ |row_matrix| (row_matrix*pattern_in_doubles).det }
    pattern_found.to_bipolar
  end

end
