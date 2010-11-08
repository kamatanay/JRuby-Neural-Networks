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
  def initialize_weight_matrix input_size
    rows = Array.new(input_size+1,Array.new(@neuron_count,0).collect{ (rand/(rand)) * ((-1.0) ** rand(2)) })
    Matrix[*rows]
  end

  def input_matrix_for inputs
    Matrix.row_vector(inputs+[1.0])
  end

  module InputLayer
    def output_for inputs
      @output = inputs.collect do |value|
        apply_activation value 
      end
    end
  end

  module ProcessingLayer
    def output_for inputs
      @matrix ||= initialize_weight_matrix inputs.size
      input_matrix = input_matrix_for inputs
      @output = (0..@neuron_count-1).to_a.collect do |index|
        weight_column = Matrix.column_vector @matrix.column(index)
        apply_activation((input_matrix*weight_column)[0,0])
      end
    end
  end

end