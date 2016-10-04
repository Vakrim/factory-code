class FCode::FactoryIO

  DIRECTIONS = {
    top: Vector[0, -1],
    left: Vector[-1, 0],
    right: Vector[1, 0],
    bottom: Vector[0, 1]
  }

  attr_reader :factory, :direction, :action

  def initialize(factory, direction, action)
    @factory = factory
    @direction = direction
    @action = action
  end

  def position
    factory.position + DIRECTIONS[@direction]
  end

  def set_package(content)
    factory.code.create_package FCode::Package.new(position, content)
  end

  def read_package
    factory.code.destroy_package position
  end
end
