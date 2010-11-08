require 'init'

class BackPropagation

  attr_reader :error

  def initialize(network, layers, inputs, ideal, learning_rate, momentum)
    @network = network
    @inputs = inputs
    @ideal = ideal
    @learning_rate = learning_rate
    @momentum = momentum
    @layers = layers.dup.reverse
    @output_layer = @layers.shift    
    @backpropagation_layers = @layers.inject({}){ |hash, layer| hash.merge({layer => BackPropagationLayer.new(layer)}) }
    @backpropagation_layers[@output_layer] = BackPropagationLayer.new @output_layer, BackPropagationLayer::OutputLayer 
  end

  def iteration
    @inputs.each_with_index do |input,index|
      output = @network.output_for(input)
      calculate_error output, @ideal[index]
    end
    learn
    @error = @network.calculate_error @inputs, @ideal
    @network
  end

  private

  def learn
    @layers.inject(@backpropagation_layers[@output_layer]) do |next_backpropagation_layer, current_layer|
      @backpropagation_layers[current_layer].learn @learning_rate, @momentum, next_backpropagation_layer
      @backpropagation_layers[current_layer]
    end
  end
  
  def calculate_error(output, ideal)
    @backpropagation_layers.values.each{|backpropagation_layer| backpropagation_layer.clear_error }
    @backpropagation_layers[@output_layer].calculate_error(output, ideal)
    @layers.inject(@backpropagation_layers[@output_layer]) do |next_backpropagation_layer, current_layer|
      @backpropagation_layers[current_layer].propagate_error next_backpropagation_layer
      @backpropagation_layers[current_layer]
    end
  end

end