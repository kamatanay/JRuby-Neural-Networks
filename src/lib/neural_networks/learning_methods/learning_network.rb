require 'init'
require 'matrix'
require 'empty_logger'

class LearningNetwork

  def initialize initial_weights, logger = EmptyLogger.new
    @weights = Matrix.row_vector initial_weights
    @logger = logger    
  end

  def train_with(inputs,required_output = nil,&learning_rule)
    input_matrix = Matrix.column_vector inputs
    output = (@weights * input_matrix).det * 0.5
    weight_modifications = input_matrix.transpose.collect{ | input_item | learning_rule.call(input_item, output, required_output) }
    @weights = @weights + weight_modifications
    @logger.log("For pattern #{inputs}, result = #{output}, weight modifications = #{weight_modifications.to_a}")
  end

end