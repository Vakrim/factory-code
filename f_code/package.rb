class FCode::Package

  attr_reader :content
  attr_accessor :position

  def initialize(position, content)
    @position = position
    @content = content
    @did_move = false
  end

  def move(direction)
    return false if @did_move
    @div_move = true
    self.position += FCode::VECTOR_DIRECTIONS[direction]
    true
  end
end
