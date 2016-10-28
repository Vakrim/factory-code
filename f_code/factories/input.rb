class FCode::Factories::Input < FCode::Factory

  def initialize(code, position, neighborhood)
    @queue = Array.new(15) { |n| n.to_s }
    super
  end

  def step
    set_main @queue.shift if @queue.length > 0
  end

  def self.symbol
    :I
  end
end
