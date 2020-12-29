# frozen_string_literal: true

require 'gosu'

require_relative 'rigid_object'

##
# Rectangular screen object.
class Rectangle < RigidObject
  def initialize(center, mass, width, height, color)
    super(center, mass)
    @width = width
    @height = height
    @color = color || Gosu::Color::WHITE
  end

  def draw
    half_diagonal = Vector[@width / 2, @height / 2]
    top_left = @center - half_diagonal
    Gosu.draw_rect(top_left[0], top_left[1], @width, @height, @color)
  end
end
