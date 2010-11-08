require 'init'
require 'neural_networks/feed_forward/feed_forward_network_builder'
require 'neural_networks/feed_forward/feed_forward_layer'

builder = FeedForwardNetworkBuilder.new
network_builder = builder.
              add_layer(FeedForwardLayer.new 2 ).
              add_layer(FeedForwardLayer.new 3).
              add_layer(FeedForwardLayer.new 1).
              using_inputs([ [ 0.0, 0.0 ], [ 1.0, 0.0 ], [ 0.0, 1.0 ], [ 1.0, 1.0 ] ]).
              using_outputs([ [ 0.0 ], [ 1.0 ], [ 1.0 ], [ 0.0 ] ]).
              train_with_backpropagation

5000.times do
  network_builder.iteration
  puts network_builder.error
end




