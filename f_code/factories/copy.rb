class FCode::Factories::Copy < FCode::Factory

  def step

  end

  def self.symbol
    :C
  end

  def on_all_inputs_full
    package = get_main
    outputs = [@main_output, @right_output, @left_output].select { |dir| dir }.each do |output|
      output.set_package package
    end
  end
end
