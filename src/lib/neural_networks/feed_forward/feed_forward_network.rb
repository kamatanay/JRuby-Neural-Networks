require 'init'
require 'neural_networks/feed_forward/error_calculator'

class FeedForwardNetwork

  def initialize layers
    initialize_network_layers layers.dup
  end

  def output_for input
    accept input
    processing_layers.inject(output_of_input_layer) { |input, layer| layer.output_for input }
  end

  def calculate_error inputs, ideal
    error_calculator = ErrorCalculator.new
    inputs.each_with_index { |input,index| error_calculator.update_error output_for(input), ideal[index] }
    error_calculator.root_mean_square_error
  end

  private

  def initialize_network_layers layers
    @input_layer = layers.first
    @output_layer = layers.last
    @hidden_layers = layers[1..-2]        
  end

  def accept input
    @input = input
  end

  def output_of_input_layer
    @input_layer.output_for @input   
  end

  def processing_layers
    (@hidden_layers + [@output_layer])
  end

end