# frozen_string_literal: true

require_relative 'vector_reflect'

##
# Object with a center of mass and motion.
class RigidObject
  # Gravitational constant, increased by a few orders of magnitude to make things interesting.
  G = 6.67408E-6

  NUDGE = 0.001

  def initialize(center, mass, velocity = nil, bounciness = 1.0)
    super()
    @center = center
    @mass = mass
    @velocity = velocity || Vector[0, 0]
    @bounciness = bounciness

    @acceleration = Vector[0, 0]
  end

  attr_accessor :center, :mass, :velocity, :bounciness

  def accelerate!(force)
    @acceleration += force / @mass
  end

  def update!
    @velocity += @acceleration
    @center += @velocity

    @acceleration[0] = @acceleration[1] = 0
  end

  def interact!(other)
    # Apply gravitational acceleration
    attract!(other)

    # Check if this object collides with the other
    point_normal = collision(other)
    return if point_normal.nil?

    # Bounce off the other object
    _, normal = point_normal

    velocity_angle = @velocity.angle_with(other.velocity)
    if velocity_angle < Math::PI
      reflection = @velocity.reflect(normal)
      accelerate!(-@velocity + reflection * @bounciness)
    end

    # ... And nudge outward, to avoid getting stuck within the other object
    @center += normal * -NUDGE
  end

  ##
  # Apply gravitational attraction based on another object's position and mass.
  def attract!(other)
    self_to_other = (other.center - @center)
    distance = self_to_other.magnitude
    return if distance < Float::EPSILON

    force_magnitude = G * @mass * other.mass / (distance**2)
    acceleration = self_to_other * force_magnitude
    accelerate!(acceleration)
  end

  ##
  # Calculate whether this object collides with another. Return surface point and normal vector, or nil.
  def collision(_)
    raise 'Not implemented'
  end
end
