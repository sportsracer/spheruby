# frozen_string_literal: true

require_relative 'vector'

##
# Object with a center of mass and motion.
class RigidObject
  # Gravitational constant, increased by a few orders of magnitude to make things interesting.
  G = 6.67408E-5

  # Percentage of collision overlap to correct for every tick
  NUDGE = 0.1

  def initialize(center, mass, velocity = nil, bounciness = 1.0)
    super()
    @center = center
    @mass = mass
    @velocity = velocity || Vector[0, 0]
    @bounciness = bounciness

    @acceleration = Vector[0, 0]
    @nudge = Vector[0, 0]
  end

  attr_accessor :center, :mass, :velocity, :bounciness

  def accelerate!(force)
    @acceleration += force / @mass
  end

  def update!
    @velocity += @acceleration
    @center += @velocity + @nudge

    @acceleration[0] = @acceleration[1] = 0
    @nudge[0] = @nudge[1] = 0
  end

  def interact!(other)
    # Apply gravitational acceleration
    attract!(other)

    collide_with!(other)
  end

  ##
  # Calculate whether this object collides with another. Return surface point and normal vector, or nil.
  def collision(_) = raise 'Not implemented'

  protected

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
  # Check if this object collides with the other, and correct our own velocity and position, if necessary. Does not
  # modify the other object.
  #
  # Return true if this object collided with other.
  def collide_with!(other)
    # Check if this object collides with the other
    point_normal = collision(other)
    return false if point_normal.nil?

    # Bounce off the other object
    depth, normal = point_normal

    impulse = collision_impulse(other, normal)
    return false if impulse.nil?

    accelerate!(normal * impulse / @mass)

    # ... And nudge outward, to avoid getting stuck within the other object
    @nudge += normal * (-NUDGE * depth)

    true
  end

  ##
  # If we are colliding with another object, calculate the total impulse of the collision, normalized by total mass.
  def collision_impulse(other, normal)
    rel_velocity = other.velocity - @velocity
    vel_along_normal = rel_velocity.dot normal
    return if vel_along_normal.positive?

    bounciness = [other.bounciness, @bounciness].min
    impulse = (1 + bounciness) * vel_along_normal
    impulse / (1 / other.mass + 1 / @mass)
  end
end
