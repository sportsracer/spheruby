# frozen_string_literal: true

require 'matrix'

# Extend the Vector class from the stdlib.
class Vector
  ##
  # Reflect this vector along a surface normal
  def reflect(normal)
    raise ArgumentError, 'Cannot reflect on zero-length normal' if normal.magnitude < Float::EPSILON

    self - normal * 2 * dot(normal)
  end
end
