class Vector2
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def *(other)
    case other
    when Numeric
      Vector2.new(@x * other, @y * other)
    when Vector2
      @x * other.x + @y * other.y
    else
      raise TypeError, "Multiplicação não suportada para #{other.class}"
    end
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  def coerce(other)
    if other.is_a?(Numeric)
      [self, other]
    else
      raise TypeError, "Coercion not supported for #{other.class}"
    end
  end
end

v = Vector2.new(3, 4)
puts v * 2
puts v * 2.5
puts v * v
puts 2 * v
puts 2.5 * v
