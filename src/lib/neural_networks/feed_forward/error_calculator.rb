require 'init'

class ErrorCalculator

  def initialize
    @global_error = 0.0
    @count_of_outputs = 0.0
  end

  def update_error output, ideal
    output.each_with_index { |output_value,index| add_to_global_error delta_square(ideal[index], output_value) }
    update_count_of_outputs ideal.size
  end

  def root_mean_square_error
    Math.sqrt @global_error/@count_of_outputs
  end

  private
  def delta_square ideal, output
    (ideal-output)**2        
  end

  def add_to_global_error value
    @global_error += value
  end

  def update_count_of_outputs increment
    @count_of_outputs += increment
  end

end