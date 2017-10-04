class FCode::Factories::Output < FCode::Factory

  attr_reader :output

  def initialize(code, position, neighborhood)
    @output = []
    super
  end

  def step

  end

  def self.symbol
    :O
  end

  def on_all_inputs_full
    @output.push get_main
  end
end
