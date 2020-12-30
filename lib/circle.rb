# frozen_string_literal: true

require 'gosu'

require_relative 'gosu_circle'
require_relative 'rigid_object'

##
# Circular screen object.
class Circle < RigidObject
  def initialize(center, mass, radius, color)
    super(center, mass)
    @radius = radius
    @color = color || Gosu::Color::WHITE
  end

  def draw
    Gosu.draw_circle(@center[0], @center[1], @radius, @color, mode: :additive)
  end
end
