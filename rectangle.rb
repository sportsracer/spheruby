# frozen_string_literal: true

require 'gosu'

require_relative 'rigid_object'

##
# Rectangular screen object.
class Rectangle < RigidObject
  def initialize(center, mass, width, height)
    super(center, mass)
    @width = width
    @height = height
  end

  def draw
    half_diagonal = Vector[@width / 2, @height / 2]
    top_left = @center - half_diagonal
    Gosu.draw_rect(top_left[0], top_left[1], @width, @height, Gosu::Color::WHITE)
  end
end
