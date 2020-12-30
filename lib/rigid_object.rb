# frozen_string_literal: true

##
# Object with a center of mass and motion.
class RigidObject
  # Gravitational constant, increased by a few orders of magnitude to make things interesting.
  G = 6.67408E-6

  def initialize(center, mass, velocity = nil)
    super()
    @center = center
    @mass = mass
    @velocity = velocity || Vector[0, 0]
  end

  attr_accessor :center, :mass, :velocity

  def accelerate(force)
    @velocity += force / @mass
  end

  def update!
    @center += @velocity
  end

  ##
  # Apply gravitational attraction based on another object's position and mass.
  def attract!(other)
    self_to_other = (other.center - @center)
    distance = self_to_other.magnitude
    return if distance < Float::EPSILON

    force_magnitude = G * @mass * other.mass / (distance**2)
    acceleration = self_to_other * force_magnitude
    accelerate(acceleration)
  end
end
