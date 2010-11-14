$: << File.expand_path(File.dirname(__FILE__)+"/lib")

require 'neural_networks/common_functions/bipolar'
require 'neural_networks/common_functions/float_bound'
require 'neural_networks/common_functions/matrix_functions'
require 'neural_networks/common_functions/array_functions'
require 'neural_networks/common_functions/integer_functions'

Array.send :include, CommonFunctions::Bipolar
Array.send :include, CommonFunctions::ArrayFunctions
Float.send :include, CommonFunctions::FloatBound
Fixnum.send :include, CommonFunctions::IntegerFunctions
Matrix.send :include, CommonFunctions::MatrixFunctions::InstanceFunctions
Matrix.send :extend, CommonFunctions::MatrixFunctions::ClassFunctions