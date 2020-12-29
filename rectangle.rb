require "gosu"

##
# Rectangular screen object.

class Rectangle
  def initialize(top_left, bottom_right)
    super()
    @top_left = top_left
    @bottom_right = bottom_right
  end

  def width
    @bottom_right[0] - @top_left[0]
  end

  def height
    @bottom_right[1] - @top_left[1]
  end

  def draw
    Gosu::draw_rect(@top_left[0], @top_left[1], width, height, Gosu::Color::WHITE)
  end
end
