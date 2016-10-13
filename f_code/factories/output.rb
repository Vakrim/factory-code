class FCode::Factories::Output < FCode::Factory

  def step

  end

  def self.symbol
    :O
  end

  def on_all_inputs_full
    puts get_main
  end
end
