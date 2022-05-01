# frozen_string_literal: true

require 'gosu'

require_relative 'gosu_circle'
require_relative 'rigid_object'

# rubocop:disable Metrics/ParameterLists

##
# Circular screen object.
class Circle < RigidObject
  def initialize(center, mass, radius, color = nil, velocity = nil, bounciness = 1.0)
    super(center, mass, velocity, bounciness)
    @radius = radius
    @color = color || Gosu::Color::WHITE
  end

  attr_accessor :radius, :color

  def draw
    @center => x, y
    Gosu.draw_circle(x, y, @radius, @color, mode: :additive)
  end

  def collision(other)
    case other
    # Only collision with other circles is implemented
    in Circle

      # Two circles are colliding if their centers are closer than the sum of their radii
      self_to_other = (other.center - @center)
      distance = self_to_other.magnitude
      collision_depth = other.radius + @radius - distance
      return if collision_depth.negative?

      normal = self_to_other.normalize
      [collision_depth, normal]
    end
  end
end

# rubocop:enable Metrics/ParameterLists
