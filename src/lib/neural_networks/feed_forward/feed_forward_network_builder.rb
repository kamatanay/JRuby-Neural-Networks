require 'init'
require 'neural_networks/feed_forward/feed_forward_network'
require 'neural_networks/feed_forward/trainer/back_propagation'
require 'neural_networks/feed_forward/trainer/back_propagation_layer'

class FeedForwardNetworkBuilder

  def initialize
    @layers = []
  end

  def add_layer(layer)
    @layers << layer
    self
  end

  def using_inputs(inputs)
    @inputs = inputs
    self
  end

  def using_outputs(outputs)
    @outputs = outputs
    self
  end

  def train_with_backpropagation
    BackPropagation.new FeedForwardNetwork.new(@layers), @layers, @inputs, @outputs, 0.7, 0.9
  end

end