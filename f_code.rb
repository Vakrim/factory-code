require 'colorize'
require 'matrix'

require_relative 'core_ext'

module FCode
  BELTS_SYMS = %i(^ > v <)
  EMPTY_SPACE_SYM = :' '
  BELTS_DIRECTIONS = {
    '^': :top,
    '<': :left,
    '>': :right,
    'v': :bottom
  }
  VECTOR_DIRECTIONS = {
    top: Vector[0, -1],
    left: Vector[-1, 0],
    right: Vector[1, 0],
    bottom: Vector[0, 1]
  }

  module Factories; end
end

require_relative 'f_code/code'
require_relative 'f_code/factory_io'
require_relative 'f_code/factory'
require_relative 'f_code/interpreter'
require_relative 'f_code/package'
require_relative 'f_code/packages_space'


Dir["f_code/factories/*.rb"].each { |file| require_relative file }
