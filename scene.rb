##
# A collection of objects which can be drawn.

class Scene
  def initialize
    super
    @objects = []
  end

  def add_object(object)
    @objects.append(object)
  end

  def draw
    @objects.each do |object|
      object.draw
    end
  end
end
