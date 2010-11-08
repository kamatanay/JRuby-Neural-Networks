require 'init'
require 'matrix'

class BackPropagationLayer

  attr_reader :feed_forward_layer, :error_delta, :error

  def initialize feed_forward_layer, layer_type = BackPropagationLayer::PropagationLayer
    @feed_forward_layer = feed_forward_layer
    @error = array_of_neuron_count
    @error_delta = array_of_neuron_count
    extend layer_type
  end

  def clear_error
    @error = array_of_neuron_count
  end

  def learn learning_rate, momentum, next_backpropagation_layer
    enhanced_with_learning_rate = @accumulated_matrix_delta * learning_rate
    enhanced_with_momemtun = @matrix_delta * momentum
    @matrix_delta = enhanced_with_learning_rate + enhanced_with_momemtun
    @accumulated_matrix_delta = nil
    next_backpropagation_layer.feed_forward_layer.matrix = next_backpropagation_layer.feed_forward_layer.matrix + @matrix_delta
    self
  end

  private
  def array_of_neuron_count
    Array.new @feed_forward_layer.neuron_count, 0.0    
  end

  def calculate_delta error, output
    error * @feed_forward_layer.apply_activation_derivative(output)
  end
  
  module OutputLayer
    def calculate_error(outputs, ideal)
      @error = (0..outputs.size-1).to_a.collect{ |index| ideal[index] - outputs[index] }
      @error_delta = @error.each_with_index{|error,index| calculate_delta(error,outputs[index]) }
    end
  end

  module PropagationLayer

    def propagate_error next_backpropagation_layer
      initialize_error_propagation next_backpropagation_layer
      next_backpropagation_layer.feed_forward_layer.neuron_count.times do |next_neuron|
        @feed_forward_layer.neuron_count.times do |current_neuron|
          accumulate_matrix_delta :from => current_neuron, :to => next_neuron, :using => (next_backpropagation_layer.error_delta[next_neuron]*@feed_forward_layer.output[current_neuron])
          @error[current_neuron] = @error[current_neuron]+next_backpropagation_layer.feed_forward_layer.matrix[current_neuron,next_neuron]*next_backpropagation_layer.error_delta[next_neuron]
        end
        accumulate_threshold_delta :for => next_neuron, :using => next_backpropagation_layer.error_delta[next_neuron]
      end
      @error_delta = (0..@error.size-1).to_a.collect{|index| calculate_delta(@error[index],@feed_forward_layer.output[index]) }
      self
    end

    private
    def initialize_error_propagation next_backpropagation_layer
      @accumulated_matrix_delta ||= next_backpropagation_layer.feed_forward_layer.matrix.collect{0.0}
      @matrix_delta ||= next_backpropagation_layer.feed_forward_layer.matrix.collect{0.0}
      @bias_row ||= @feed_forward_layer.neuron_count            
    end

    def accumulate_matrix_delta params
      matrix_array = @accumulated_matrix_delta.to_a
      matrix_array[params[:from]][params[:to]] = matrix_array[params[:from]][params[:to]] + params[:using]
      @accumulated_matrix_delta = Matrix[*matrix_array]
    end

    def accumulate_threshold_delta params
      matrix_array = @accumulated_matrix_delta.to_a
      matrix_array[@bias_row][params[:for]] = matrix_array[@bias_row][params[:for]] + params[:using]
      @accumulated_matrix_delta = Matrix[*matrix_array]
    end
    
  end

end