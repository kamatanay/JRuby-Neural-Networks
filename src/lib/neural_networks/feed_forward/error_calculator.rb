require 'init'

class ErrorCalculator

  def initialize
    @global_error = 0.0
    @count_of_outputs = 0.0
  end

  def update_error output, ideal
    output.each_with_index do |output_value,index|
      delta = ideal[index]-output_value
      @global_error = @global_error+(delta*delta)
    end
    @count_of_outputs = @count_of_outputs+ideal.size 
  end

  def root_mean_square_error
    Math.sqrt(@global_error/@count_of_outputs)
  end

end