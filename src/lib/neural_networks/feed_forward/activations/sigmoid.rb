module Sigmoid

  def apply_activation(value)
    1.0 / (1.0 + (Math.exp(-1.0 * value)).network_bound)
  end

  def apply_activation_derivative(value)
    (value * (1.0 - value)).network_bound
  end

end