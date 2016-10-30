class FCode::FactoryIO

  attr_reader :factory, :direction, :action

  def initialize(factory, direction, action)
    @factory = factory
    @direction = direction
    @action = action
  end

  def position
    factory.position + FCode::VECTOR_DIRECTIONS[@direction]
  end

  def set_package(content)
    factory.code.packages.create FCode::Package.new(position, content)
  end

  def read_package
    factory.code.packages.read position
  end

  def get_package
    factory.code.packages.destroy position
  end
end
