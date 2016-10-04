require 'pry'
require_relative 'f_code'

code = FCode::Code.new 'subtract.fc'
interpreter = FCode::Interpreter.new(code)

code.debug
