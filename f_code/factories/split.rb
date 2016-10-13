class FCode::Factories::Split < FCode::Factory

  def step

  end

  def on_main_input_full
    info = get_main
    @cycle ||= 0
    outputs = [@main_output, @right_output, @left_output].select { |dir| dir }
    @cycle %= outputs.count
    outputs[@cycle].set_package info
    @cycle = @cycle + 1
  end

  def self.symbol
    :S
  end
end
