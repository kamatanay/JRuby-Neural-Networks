require 'init'
require 'neural_networks/feed_forward/feed_forward_network_builder'
require 'neural_networks/feed_forward/feed_forward_layer'

INPUTS = [ [ 0.0, 0.0 ], [ 1.0, 0.0 ], [ 0.0, 1.0 ], [ 1.0, 1.0 ] ]
IDEAL_OUTPUTS = [ [ 0.0 ], [ 1.0 ], [ 1.0 ], [ 0.0 ] ] 

builder = FeedForwardNetworkBuilder.new
backpropagation_trainer = builder.
              add_layer(FeedForwardLayer.new 2 ).
              add_layer(FeedForwardLayer.new 3).
              add_layer(FeedForwardLayer.new 1).
              train_with_backpropagation

error = nil
5000.times do
  error = backpropagation_trainer.iteration INPUTS, IDEAL_OUTPUTS, 0.7, 0.9
end

network = backpropagation_trainer.network

puts network.output_for([0.0,0.0])
puts network.output_for([0.0,1.0])
puts network.output_for([1.0,0.0])
puts network.output_for([1.0,1.0])




