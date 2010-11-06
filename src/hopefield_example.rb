require 'init'
require 'neural_networks/hopefield/hopefield_network'

network = HopefieldNetwork.trained_using([true,false,true])
p network.present [true,false,true]

