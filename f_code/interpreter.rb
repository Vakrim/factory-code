class FCode::Interpreter

  attr_reader :code

  def initialize(code)
    @code = code
  end

  def step
    code.factories.each(&:step!)
    code.packages.move_all
  end

  def input=(i)
    code.factories.select { |factory| factory.is_a? FCode::Factories::Input }.each do |factory|
      factory.input = i
    end
  end

  def output
    output_factory = code.factories.find { |factory| factory.is_a? FCode::Factories::Output }
    output_factory.output
  end
end
