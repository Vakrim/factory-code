require 'pry'
require_relative 'f_code'

code = FCode::Code.new 'swap.fc'
interpreter = FCode::Interpreter.new(code)

code.debug

100.times { interpreter.step }
