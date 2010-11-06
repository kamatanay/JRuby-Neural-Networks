require 'init'
require 'neural_networks/learning_methods/learning_network'

learning_rate = 0.5

def error output,required_output
  required_output - output    
end

network = LearningNetwork.new [0,0,0] do |inputs,required_output,output,weight_modifications|
  puts "For pattern #{inputs}, required output = #{required_output}, actual output = #{output}, error = #{error output,required_output }"
end

block = Proc.new do |input_item, output, required_output|
  learning_rate * input_item * error(output,required_output)
end

100.times do |index|
  puts "***Beginning Epoch ##{index} ***"
  network.train_with [0,0,1],0,&block
  network.train_with [0,1,1],0,&block
  network.train_with [1,0,1],0,&block
  network.train_with [1,1,1],1,&block
end
