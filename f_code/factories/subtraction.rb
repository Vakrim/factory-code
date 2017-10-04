class FCode::Factories::Subtraction < FCode::Factory

  def step

  end

  def self.symbol
    :-
  end

  def on_all_inputs_full
    minued = get_main
    subrahend = [@right_input, @left_input].find { |dir| dir }.get_package
    set_main minued - subrahend
  end
end
