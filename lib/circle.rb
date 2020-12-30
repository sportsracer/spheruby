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
    Gosu.draw_circle(@center[0], @center[1], @radius, @color, mode: :additive)
  end

  def collision(other)
    # Only collision with other circles is implemented
    return unless other.instance_of? Circle

    # Two circles are colliding if their centers are closer than the sum of their radii
    self_to_other = (other.center - @center)
    distance = self_to_other.magnitude
    return if distance > (other.radius + @radius)

    # Calculate collision point and normal
    direction = self_to_other.normalize
    point = @center + direction * @radius

    [point, direction]
  end
end

# rubocop:enable Metrics/ParameterLists
