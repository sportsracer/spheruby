# frozen_string_literal: true

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

  def update
    @objects.each(&:update)
  end

  def draw
    @objects.each(&:draw)
  end
end
