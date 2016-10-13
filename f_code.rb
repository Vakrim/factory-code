require 'colorize'
require 'matrix'

require_relative 'core_ext'

module FCode
  module Factories; end
end

require_relative 'f_code/code'
require_relative 'f_code/factory_io'
require_relative 'f_code/factory'
require_relative 'f_code/interpreter'
require_relative 'f_code/package'


Dir["f_code/factories/*.rb"].each { |file| require_relative file }
