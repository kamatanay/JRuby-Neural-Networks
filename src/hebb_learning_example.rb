require 'init'
require 'neural_networks/learning_methods/learning_network'
require 'console_logger'

learning_rate = 1

network = LearningNetwork.new [1,-1], ConsoleLogger.new

block = Proc.new do |input_item, output, required_output|
  learning_rate * input_item * output
end

100.times do |index|
  puts "***Beginning Epoch ##{index} ***"
  network.train_with([-1,-1],nil,&block)
  network.train_with([-1,1],nil,&block)
  network.train_with([1,-1],nil,&block)
  network.train_with([1,1],nil,&block)
end
