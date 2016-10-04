class Class
  def descendants
    descendants = []
    ObjectSpace.each_object(singleton_class) do |k|
      descendants.unshift k unless k == self
    end
    descendants
  end
end
