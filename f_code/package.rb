class FCode::Package

  attr_reader :content
  attr_accessor :position

  def initialize(position, content)
    @position = position
    @content = content
  end

end
