require 'init'
require 'neural_networks/hopfield/hopfield_network'

network = HopfieldNetwork.trained_using([true,false,true])
p network.present [true,false,true]

