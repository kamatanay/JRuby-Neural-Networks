require 'init'

class BackPropagation

  attr_reader :network

  def initialize(network, layers)
    accept_network network
    initialize_layers layers.dup
    initialize_backpropagation_layers
  end

  def iteration inputs, ideal, learning_rate, momentum
    inputs.each_with_index { |input,index| calculate_error network_output_for(input), ideal[index] }
    learn_from_errors learning_rate, momentum
    network.calculate_error inputs, ideal
  end

  private

  def accept_network network
    @network = network
  end

  def initialize_layers layers
    @layers = layers.reverse
    @output_layer = @layers.shift
  end

  def initialize_backpropagation_layers
    @backpropagation_layers = processing_layers.map_to_hash { |layer| BackPropagationLayer.new layer }
    @backpropagation_layers[output_network_layer] = BackPropagationLayer.new @output_layer, BackPropagationLayer::OutputLayer
  end

  def network_output_for input
    @network.output_for input
  end

  def learn_from_errors learning_rate, momentum
    processing_layers.inject(output_backpropagation_layer) { |next_backpropagation_layer, current_layer| backpropagation_layers[current_layer].learn learning_rate, momentum, next_backpropagation_layer }
  end
  
  def calculate_error(output, ideal)
    clear_backpropagation_errors
    calculate_output_error output, ideal 
    processing_layers.inject(output_backpropagation_layer) { |next_backpropagation_layer, current_layer| backpropagation_layers[current_layer].propagate_error next_backpropagation_layer }
  end

  def clear_backpropagation_errors
    backpropagation_layers.values.each {|layer| layer.clear_error }
  end

  def calculate_output_error(output, ideal)
    backpropagation_layers[output_network_layer].calculate_error(output, ideal)
  end

  def processing_layers
    @layers   
  end

  def output_backpropagation_layer
    backpropagation_layers[output_network_layer]
  end

  def output_network_layer
    @output_layer
  end

  def backpropagation_layers
    @backpropagation_layers
  end

end