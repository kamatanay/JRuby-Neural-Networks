require 'init'
require 'neural_networks/common_functions/bipolar'
require 'neural_networks/hopefield/hopefield_trained_network'
require 'matrix'

class HopefieldNetwork

  Array.send :include, CommonFunctions::Bipolar

  def self.trained_using *patterns
    weight_matrix = patterns.inject(Matrix.zero patterns.first.size){ |weights,pattern| weights+weights_for(pattern) }
    HopefieldTrainedNetwork.new weight_matrix
  end

  private
  
  def self.weights_for pattern
    new_matrix = Matrix.column_vector(pattern.to_double)
    transposed_matrix = new_matrix.transpose

    identity_matrix = Matrix.identity new_matrix.row_size
    (new_matrix * transposed_matrix) - identity_matrix
  end
end
    