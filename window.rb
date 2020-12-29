require "matrix"

require "gosu"

require_relative "camera"
require_relative "rectangle"
require_relative "scene"

##
# Gosu game window for drawing a scene, from the viewpoint of a camera.

class Window < Gosu::Window
  def initialize(width, height, *args)
    super
    @scene = Scene.new
    @scene.add_object(Rectangle.new(Vector[-1, -1], Vector[1, 1]))
    @camera = Camera.new(Vector[0, 0], 0.5)
  end

  def update
    # do nothing
  end

  def window_transform(&block)
    translate(width/2, height/2) do
      scale(width/2, width/2) do
        block.call
      end
    end
  end

  def draw
    super
    window_transform do
      @camera.transform do
        @scene.draw
      end
    end
  end
end
