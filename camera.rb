##
# Transformation from world to viewport coordinates.

class Camera
  def initialize(center, scale)
    super()
    @center = center
    @scale = scale
  end

  def transform(&block)
    Gosu::scale(@scale, @scale) do
      Gosu::translate(-@center[0], -@center[1]) do
        block.call
      end
    end
  end
end
