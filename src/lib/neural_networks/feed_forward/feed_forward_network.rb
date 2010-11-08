require 'init'
require 'neural_networks/feed_forward/error_calculator'

class FeedForwardNetwork

  attr_accessor :input_layer, :output_layer

  def initialize layers
    related_layers = layers.dup
    @input_layer = related_layers.first
    @output_layer = related_layers.last
    related_layers.shift
    related_layers.pop
    @hidden_layers = related_layers
  end

  def output_for input
    output_of_input_layer = @input_layer.output_for input
    (@hidden_layers + [@output_layer]).inject(output_of_input_layer) do |input, layer|
      layer.output_for(input)
    end
  end

  def calculate_error inputs, ideal
    error_calculator = ErrorCalculator.new
    inputs.each_with_index do |input,index|
      output = output_for input
      error_calculator.update_error output, ideal[index]
    end
    error_calculator.root_mean_square_error
  end

  private

  def layer_data_hash is_input, neuron_count, output
    {:input => is_input, :neuron_count => neuron_count, :output => output}
  end

end