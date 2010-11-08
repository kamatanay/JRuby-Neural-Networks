require 'init'
require 'matrix'

class BackPropagationLayer

  attr_reader :feed_forward_layer

  def initialize feed_forward_layer, layer_type = BackPropagationLayer::PropagationLayer
    accept_feedforward_layer feed_forward_layer
    extend layer_type
  end

  def clear_error
    @error = nil
  end

  def learn learning_rate, momentum, next_backpropagation_layer
    enhance_accumulated_matrix_delta_with_learning_rate = accumulated_matrix_delta * learning_rate
    enhance_metrix_delta_with_momemtun = matrix_delta * momentum
    set_matrix_delta(enhance_accumulated_matrix_delta_with_learning_rate + enhance_metrix_delta_with_momemtun)
    next_backpropagation_layer.feed_forward_layer.matrix += matrix_delta
    clear_accumulated_matrix_delta    
    self
  end

  def error
    @error ||= Array.new neuron_count, 0.0
  end

  def error_delta
    @error_delta ||= Array.new neuron_count, 0.0
  end

  private

  def clear_accumulated_matrix_delta
    @accumulated_matrix_delta = nil
  end

  def accumulated_matrix_delta
    @accumulated_matrix_delta
  end

  def matrix_delta
    @matrix_delta
  end

  def set_matrix_delta(delta_matrix)
    @matrix_delta = delta_matrix 
  end

  def accept_feedforward_layer layer
    @feed_forward_layer = layer
  end

  def neuron_count
    feed_forward_layer.neuron_count
  end

  def calculate_delta error, output
    error * feed_forward_layer.apply_activation_derivative(output)
  end
  
  module OutputLayer
    def calculate_error(outputs, ideal)
      error.size.times{ |index| error[index] = ideal[index] - outputs[index] }
      error_delta.size.times { | index| error_delta[index] = calculate_delta(error[index],outputs[index]) }
    end
  end

  module PropagationLayer

    def propagate_error next_backpropagation_layer
      initialize_error_propagation next_backpropagation_layer
      neuron_count_in_next_layer.times do |next_neuron|
        determine_error_from_current_layer_to next_neuron
        accumulate_threshold_delta next_neuron, next_backpropagation_layer.error_delta[next_neuron]
      end
      determine_error_delta_for_current_layer
      self
    end

    private

    def determine_error_delta_for_current_layer
      error_delta.size.times {|index| error_delta[index] = calculate_delta(error[index],feed_forward_layer.output[index]) }      
    end

    def determine_error_from_current_layer_to(next_neuron)
      neuron_count.times do |current_neuron|
        accumulate_matrix_delta current_neuron, next_neuron
        error[current_neuron] += next_backpropagation_layer.feed_forward_layer.matrix[current_neuron,next_neuron]*next_backpropagation_layer.error_delta[next_neuron]
      end
    end

    def accumulated_matrix_delta_contribution(from, to)
      feed_forward_layer.output[from] * next_backpropagation_layer.error_delta[to]      
    end

    def neuron_count_in_next_layer
      next_backpropagation_layer.feed_forward_layer.neuron_count
    end

    def initialize_error_propagation next_backpropagation_layer
      @next_backpropagation_layer = next_backpropagation_layer
      @accumulated_matrix_delta ||= next_backpropagation_layer.feed_forward_layer.matrix.collect{0.0}
      @matrix_delta ||= next_backpropagation_layer.feed_forward_layer.matrix.collect{0.0}
      @bias_row ||= @feed_forward_layer.neuron_count            
    end

    def next_backpropagation_layer
      @next_backpropagation_layer
    end

    def accumulate_matrix_delta from, to
      matrix_array = @accumulated_matrix_delta.to_a
      matrix_array[from][to] += accumulated_matrix_delta_contribution(from,to)
      @accumulated_matrix_delta = Matrix[*matrix_array]
    end

    def accumulate_threshold_delta for_neuron, delta_value
      matrix_array = @accumulated_matrix_delta.to_a
      matrix_array[@bias_row][for_neuron] +=  delta_value
      @accumulated_matrix_delta = Matrix[*matrix_array]
    end
    
  end

end