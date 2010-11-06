require 'init'
require 'matrix'

class LearningNetwork

  def initialize initial_weights, &logger_block
    @weights = Matrix.row_vector initial_weights
    @logger_block = logger_block    
  end

  def train_with(inputs,required_output = nil,&learning_rule)
    input_matrix = Matrix.column_vector inputs
    output = (@weights * input_matrix).det * 0.5
    weight_modifications = input_matrix.transpose.collect{ | input_item | learning_rule.call(input_item, output, required_output) }
    @weights = @weights + weight_modifications
    @logger_block.call(inputs,required_output,output,weight_modifications) if block_given?
  end

end