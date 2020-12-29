# frozen_string_literal: true

##
# Object with a center of mass and motion.
class RigidObject
  def initialize(center, mass, velocity = nil)
    super()
    @center = center
    @mass = mass
    @velocity = velocity || Vector[0, 0]
  end

  def accelerate(force)
    @velocity += force / @mass
  end

  def update
    @center += @velocity
  end
end
