class FCode::Interpreter

  attr_reader :code

  def initialize(code)
    @code = code
  end

  def step
    code.factories.each(&:step!)
    code.packages.move_all
  end
end
