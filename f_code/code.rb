class FCode::Code
  BELTS_SYMS = %i(^ > v <)
  EMPTY_SPACE_SYM = :' '
  BELTS_DIRECTIONS = {
    '^': :top,
    '<': :left,
    '>': :right,
    'v': :bottom
  }
  VECTOR_DIRECTIONS = {
    top: Vector[0, -1],
    left: Vector[-1, 0],
    right: Vector[1, 0],
    bottom: Vector[0, 1]
  }

  OutOfBoundsError = Class.new StandardError

  attr_reader :factories

  def initialize(file)
    @code_string = File.read file
    @factories = []
    @packages = []
    break_code_into_array!
    insert_factories!
  end

  def insert_factories!
    FCode::Factory.register_factories!
    @factories = []
    @code.map!.with_index do |symbol, index|
      if BELTS_SYMS.include?(symbol) || symbol == EMPTY_SPACE_SYM
        symbol
      else
        factory = FCode::Factory.new_factory(symbol, self, index_to_position(index), neighborhood(index))
        @factories << factory
        factory
      end
    end
  end

  def debug
    # @code_string.tr('<', "\u21e0").tr('^', "\u21e1").tr('>', "\u21e2").tr('v', "\u21e3").gsub(/(.)/, '\1 ')
    @code.each.with_index { |c, i| print c.to_s; print "\n" if (i + 1) % @width == 0 }
  end

  def [](position_or_index)
    if position_or_index.is_a? Vector
      at_position!(position_or_index)
    else
      @code[position_or_index]
    end
  end

  def at_position!(position)
    raise OutOfBoundsError if !(0..@width).cover?(position[0]) || !(0..@height).cover?(position[1])
    @code[position_to_index(position)]
  end

  def at_position(position)
    at_position!(position)
  rescue OutOfBoundsError
    nil
  end

  def neighborhood(index)
    position = index_to_position index
    {
      top:    at_position(position + VECTOR_DIRECTIONS[:top]),
      left:   at_position(position + VECTOR_DIRECTIONS[:left]),
      right:  at_position(position + VECTOR_DIRECTIONS[:right]),
      bottom: at_position(position + VECTOR_DIRECTIONS[:bottom])
    }
  end

  def index_to_position(index)
    x = index % @width
    y = index / @width
    Vector[x, y]
  end

  def position_to_index(position)
    position[0] + position[1] * @width
  end

  def create_package(package)
    @packages.push package
  end

  def destroy_package(position)
    package = @packages.find { |package| package.position == position }
    @packages.delete(package)
    package.content
  end

  def read_package(position)
    package = @packages.find { |package| package.position == position }
    package ? package.content : nil
  end

  def move_package(package)
    current_belt = at_position!(package.position)
    next_belt = at_position!(package.position + VECTOR_DIRECTIONS[BELTS_DIRECTIONS[current_belt]])
    return if !BELTS_SYMS.include?(next_belt)
    package.position += VECTOR_DIRECTIONS[BELTS_DIRECTIONS[current_belt]]
  end

  def move_packages
    @packages.each { |package| move_package package }
  end

  private

  def break_code_into_array!
    code_in_lines = @code_string.split("\n")
    @height = code_in_lines.size
    @width = code_in_lines.map(&:length).max
    code_in_lines.map! do |line|
      line.ljust @width
    end
    @code = code_in_lines.map { |line| line.split '' }.flatten.map(&:to_sym)
  end
end
