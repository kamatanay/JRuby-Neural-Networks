module Square
  def apply_activation(value)
    value ** 2
  end

  def apply_activation_derivative(value)
    value * 2
  end
end