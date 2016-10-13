class FCode::Factory

  INPUTS_AND_OUTPUTS_DIRECTIONS = {
    left:   { :> => :input, :< => :output },
    right:  { :< => :input, :> => :output },
    top:    { :v => :input, :^ => :output },
    bottom: { :^ => :input, :v => :output }
  }
  DIRECTIONS =  %i(left top right bottom)
  RIGHT_ROTATED = 4.times.map { |i| [DIRECTIONS[i], DIRECTIONS[(i + 1) % 4]] }.to_h
  OPPOSITES     = 4.times.map { |i| [DIRECTIONS[i], DIRECTIONS[(i + 2) % 4]] }.to_h
  LEFT_ROTATED  = 4.times.map { |i| [DIRECTIONS[i], DIRECTIONS[(i + 3) % 4]] }.to_h

  InputIsNotPresentError = Class.new StandardError
  OutputIsNotPresentError = Class.new StandardError

  attr_reader :code, :position

  @@factory_types = {}

  def self.register_factories!
    @@factory_types = FCode::Factory.descendants.map do |factory|
      [factory.symbol, factory]
    end.to_h
  end

  def self.new_factory(symbol, code, position, neighborhood)
    @@factory_types.fetch(symbol).new(code, position, neighborhood)
  end

  def initialize(code, position, neighborhood)
    @symbol = self.class.symbol
    @code = code
    @position = position
    parse_neighborhood! neighborhood
    create_inputs_and_outputs!
  end

  def to_s
    @symbol.to_s.colorize(:red)
  end

  def symbol
    self.class.symbol
  end

  %i(main left right).each do |direction|
    define_method "set_#{ direction }" do |content|
      raise OutputIsNotPresentError unless instance_variable_get("@#{ direction }_output")
      instance_variable_get("@#{ direction }_output").set_package(content)
    end

    define_method "read_#{ direction }" do |content|
      raise InputIsNotPresentError unless instance_variable_get("@#{ direction }_input")
      instance_variable_get("@#{ direction }_input").read_package
    end
  end

  private

  def parse_neighborhood!(neighborhood)
    @inputs_directions = []
    @outputs_directions = []
    INPUTS_AND_OUTPUTS_DIRECTIONS.each do |direction, spins|
       spin = spins[neighborhood[direction]]
       if spin == :input
         @inputs_directions << direction
       elsif spin == :output
         @outputs_directions << direction
       end
    end

    @main_input_direction = @inputs_directions.first if @inputs_directions.size == 1
    @main_output_direction = @outputs_directions.first if @outputs_directions.size == 1

    @main_input_direction ||= OPPOSITES[@main_output_direction] if @inputs_directions.include? OPPOSITES[@main_output_direction]
    @main_output_direction ||= OPPOSITES[@main_input_direction] if @outputs_directions.include? OPPOSITES[@main_input_direction]
  end

  def create_inputs_and_outputs!
    @inputs = @inputs_directions.map { |direction| FCode::FactoryIO.new(self, direction, :input) }
    @outputs = @outputs_directions.map { |direction| FCode::FactoryIO.new(self, direction, :output) }

    if @main_input_direction
      @main_input = @inputs.find { |i| i.direction == @main_input_direction }
      @left_input = @inputs.find { |i| i.direction == LEFT_ROTATED[@main_input_direction] }
      @right_input = @inputs.find { |i| i.direction == RIGHT_ROTATED[@main_input_direction] }
    end

    if @main_output_direction
      @main_output = @outputs.find { |i| i.direction == @main_output_direction }
      @left_output = @outputs.find { |i| i.direction == RIGHT_ROTATED[@main_output_direction] }
      @right_output = @outputs.find { |i| i.direction == LEFT_ROTATED[@main_output_direction] }
    end
  end
end
