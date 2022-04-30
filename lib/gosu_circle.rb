# frozen_string_literal: true

require 'gosu'

# rubocop:disable Metrics/ParameterLists
# rubocop:disable Naming/MethodParameterName

##
# Extend Gosu with capability to draw a solid circle.
module Gosu
  # How many sides to draw to approximate a circle:
  CIRCLE_SIDES = 180

  ##
  # Draw circle around (x, y) with specified radius and color.
  def self.draw_circle(x, y, radius, color, z: 0, mode: :default)
    ai = 360.0 / CIRCLE_SIDES.to_f

    translate(x, y) do
      # Draw circle as series of quads, with one point always at center, and
      # three points on the circumference of the circle.
      ang = 0
      while ang < 360.0
        next_ang = ang + ai
        next_next_ang = next_ang + ai
        _draw_circular_slice(radius, ang, next_ang, next_next_ang, color, z:, mode:)
        ang = next_next_ang
      end
    end
  end

  private_class_method def self._draw_circular_slice(radius, ang1, ang2, ang3, color, z: 0, mode: :default)
    Gosu.draw_quad(
      0, 0, color,
      Gosu.offset_x(ang1, radius), Gosu.offset_y(ang1, radius), color,
      Gosu.offset_x(ang2, radius), Gosu.offset_y(ang2, radius), color,
      Gosu.offset_x(ang3, radius), Gosu.offset_y(ang3, radius), color,
      z, mode
    )
  end
end

# rubocop:enable Metrics/ParameterLists
# rubocop:enable Naming/MethodParameterName
