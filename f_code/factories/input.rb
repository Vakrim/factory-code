class FCode::Factories::Input < FCode::Factory

  def initialize(code, position, neighborhood)
    @queue = %w(wszystko ma swoje priotrytety)
    super
  end

  def step
    set_main @queue.shift if @queue.length > 0
  end

  def self.symbol
    :I
  end
end
