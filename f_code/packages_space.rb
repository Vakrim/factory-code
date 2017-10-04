class FCode::PackagesSpace

  def initialize(code)
    @code = code
    @packages = []
  end

  def create(package)
    @packages.push package
  end

  def destroy(position)
    package = @packages.find { |package| package.position == position }
    @packages.delete(package)
    package.content
  end

  def read(position)
    package = @packages.find { |package| package.position == position }
    package ? package.content : nil
  end

  def move(package)
    current_belt = @code.at_position!(package.position)
    next_belt = @code.at_position!(package.position + FCode::VECTOR_DIRECTIONS[FCode::BELTS_DIRECTIONS[current_belt]])
    return unless FCode::BELTS_SYMS.include?(next_belt)
    package.move FCode::BELTS_DIRECTIONS[current_belt]
  end

  def move_all
    @packages.each { |package| move package }
  end
end
