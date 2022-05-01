# frozen_string_literal: true

require 'matrix'

require 'gosu'

##
# Gosu game window for drawing a scene, from the viewpoint of a camera.
class Window < Gosu::Window
  def initialize(scene, camera, width, height)
    super(width, height)
    @scene = scene
    @camera = camera
  end

  def update = @scene.update!

  def window_transform(&block)
    translate(width / 2, height / 2) do
      scale(width / 2, width / 2) do
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
