require 'init'
require 'neural_networks/feed_forward/feed_forward_network'
require 'neural_networks/feed_forward/feed_forward_layer'
require 'neural_networks/feed_forward/trainer/back_propagation'
require 'neural_networks/feed_forward/trainer/back_propagation_layer'

class FeedForwardNetworkBuilder

  def initialize layers = [], type = FeedForwardNetworkBuilder::InputLayerAcceptor 
    @layers = layers
    extend type
  end

  def build
    FeedForwardNetwork.new(@layers)  
  end

  def train_with_backpropagation
    BackPropagation.new build, @layers
  end

  module InputLayerAcceptor

    def add_layer(layer)
      @layers << layer.extend( FeedForwardLayer::InputLayer )
      FeedForwardNetworkBuilder.new @layers, FeedForwardNetworkBuilder::ProcessingLayerAcceptor
    end
    
  end

  module ProcessingLayerAcceptor

    def add_layer(layer)
      @layers << layer.extend( FeedForwardLayer::ProcessingLayer )
      self
    end

  end

end