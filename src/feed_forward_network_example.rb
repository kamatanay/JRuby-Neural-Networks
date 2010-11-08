require 'init'
require 'neural_networks/feed_forward/feed_forward_network_builder'
require 'neural_networks/feed_forward/feed_forward_layer'

INPUTS = [ [ 0.0, 0.0 ], [ 1.0, 0.0 ], [ 0.0, 1.0 ], [ 1.0, 1.0 ] ]
IDEAL_OUTPUTS = [ [ 0.0 ], [ 1.0 ], [ 1.0 ], [ 1.0 ] ] 

builder = FeedForwardNetworkBuilder.new
network_builder = builder.
              add_layer(FeedForwardLayer.new 2 ).
              add_layer(FeedForwardLayer.new 3).
              add_layer(FeedForwardLayer.new 1).
              train_with_backpropagation

5000.times do
  error = network_builder.iteration INPUTS, IDEAL_OUTPUTS, 0.7, 0.9
  puts error
end




