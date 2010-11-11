require 'init'
require 'neural_networks/feed_forward/feed_forward_network_builder'
require 'neural_networks/feed_forward/feed_forward_layer'
require 'neural_networks/feed_forward/trainer/genetic'

INPUTS = [ [ 0.0, 0.0 ], [ 1.0, 0.0 ], [ 0.0, 1.0 ], [ 1.0, 1.0 ] ]
IDEAL_OUTPUTS = [ [ 0.0 ], [ 1.0 ], [ 1.0 ], [ 0.0 ] ]

genetic = Genetic.new(INPUTS, IDEAL_OUTPUTS, 5000, 0.3, 0.4) do
            FeedForwardNetworkBuilder.new.
              add_layer(FeedForwardLayer.new 2 ).
              add_layer(FeedForwardLayer.new 3 ).
              add_layer(FeedForwardLayer.new 1).
              build
end

epoch_count = 0;

begin
  genetic.iteration
  epoch_count += 1
  puts "Epoch: #{epoch_count} Error: #{genetic.error}"
end while genetic.error > 0.01

puts ""


network = genetic.network

puts network.output_for([0.0,0.0])
puts network.output_for([0.0,1.0])
puts network.output_for([1.0,0.0])
puts network.output_for([1.0,1.0])




