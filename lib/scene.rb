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

  def update!
    apply_gravity
    @objects.each(&:update!)
  end

  def draw
    @objects.each(&:draw)
  end

  private

  ##
  # Calculate gravitational attraction between all objects.
  def apply_gravity
    @objects.each do |object1|
      @objects.each do |object2|
        next if object1 == object2

        object1.attract!(object2)
      end
    end
  end
end
