class FCode::Factory

  DIRECTIONS = {
    left:   { :> => :input, :< => :output },
    right:  { :< => :input, :> => :output },
    top:    { :v => :input, :^ => :output },
    bottom: { :^ => :input, :v => :output }
  }
  OPPOSITES = {
    left: :right,
    right: :left,
    top: :bottom,
    bottom: :top
  }
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

  private

  def parse_neighborhood!(neighborhood)
    @inputs_directions = []
    @outputs_directions = []
    DIRECTIONS.each do |direction, spins|
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

    @main_input = FCode::FactoryIO.new(self, @main_input_direction, :input) if @main_input_direction
    @main_output = FCode::FactoryIO.new(self, @main_output_direction, :output) if @main_output_direction
  end
end
