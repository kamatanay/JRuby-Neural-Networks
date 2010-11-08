require 'init'
require 'matrix'

class FeedForwardLayer

  attr_reader :neuron_count, :output
  attr_accessor :matrix

  TOO_SMALL = -1.0E20

  TOO_BIG = 1.0E20

  def initialize count_of_neuron_in_this_layer, type = FeedForwardLayer::ProcessingLayer
    @neuron_count = count_of_neuron_in_this_layer
    extend type
  end


  private
  def initialize_weight_matrix input_size
    rows = Array.new(input_size+1,Array.new(@neuron_count,0).collect{ (rand/(rand)) * ((-1.0) ** rand(2)) })
    Matrix[*rows]
  end

  def input_matrix_for inputs
    Matrix.row_vector(inputs+[1.0])
  end

  def sigmoid_of value
    sigmoid = 1.0 / (1.0 + bound(Math.exp(-1.0 * value)))
    sigmoid
  end

  def bound value
      if (value < TOO_SMALL)
          return TOO_SMALL
      else if (value > TOO_BIG)
          return TOO_BIG
        else
          return value
        end
      end
  end

  module InputLayer
    def output_for inputs
      @output = inputs.collect do |value|
        sigmoid_of value 
      end
    end
  end

  module ProcessingLayer
    def output_for inputs
      @matrix ||= initialize_weight_matrix inputs.size
      input_matrix = input_matrix_for inputs
      @output = (0..@neuron_count-1).to_a.collect do |index|
        weight_column = Matrix.column_vector @matrix.column(index)
        sigmoid_of (input_matrix*weight_column)[0,0]
      end
    end
  end

end