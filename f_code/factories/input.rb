class FCode::Factories::Input < FCode::Factory

  attr_writer :input

  def initialize(code, position, neighborhood)
    @input = []
    super
  end

  def step
    set_main @input.shift if @input.length > 0
  end

  def self.symbol
    :I
  end
end
