require 'init'
require 'matrix'
require 'neural_networks/feed_forward/activations/sigmoid'

class FeedForwardLayer

  attr_reader :neuron_count, :output
  attr_accessor :matrix

  def initialize count_of_neuron_in_this_layer, activation_method = Sigmoid
    @neuron_count = count_of_neuron_in_this_layer
    extend activation_method
  end


  private
  
  def input_matrix_for inputs
    Matrix.row_vector(inputs+[1.0])
  end

  module InputLayer
    def output_for inputs
      @output = inputs.collect { |value| apply_activation value } 
    end
  end

  module ProcessingLayer

    def output_for inputs
      matrix = weight_matrix inputs.size
      input_matrix = input_matrix_for inputs
      @output = calculate_output(input_matrix, matrix)
    end

    private

    def calculate_output(input_matrix, matrix)
      output_array_with_neuron_positions.collect { |index| apply_activation input_matrix.product_with_given_column(matrix,index) }
    end
        
    def weight_matrix input_size
      @matrix ||= Matrix.randomize input_size+1, neuron_count
    end

    def output_array_with_neuron_positions
      (0..@neuron_count-1).to_a            
    end
    
  end

end