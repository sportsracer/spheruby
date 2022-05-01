# frozen_string_literal: true

##
# Transformation from world to viewport coordinates.
class Camera
  def initialize(center, scale)
    super()
    @center = center
    @scale = scale
  end

  def transform(&block)
    Gosu.scale(@scale, @scale) do
      @center => x, y
      Gosu.translate(-x, -y) do
        block.call
      end
    end
  end
end
