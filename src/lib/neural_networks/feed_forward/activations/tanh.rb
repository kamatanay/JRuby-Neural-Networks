module Tanh
  def apply_activation(value)
    (Math.exp(value*2.0).network_bound - 1.0) / (Math.exp(value*2.0).network_bound + 1.0)
  end

  def apply_activation_derivative(value)
    ( 1.0 - (apply_activation(value)**2))
  end
end