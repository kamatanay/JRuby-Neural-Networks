$: << File.expand_path(File.dirname(__FILE__)+"/lib")

require 'neural_networks/common_functions/bipolar'
require 'neural_networks/common_functions/float_bound'

Array.send :include, CommonFunctions::Bipolar
Float.send :include, CommonFunctions::FloatBound