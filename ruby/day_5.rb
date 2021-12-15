data = File.readlines("data/day_5")

class Line
  attr_reader :point_a, :point_b

  def initialize(raw)
    a, b = raw.split(" -> ")
    @point_a = Point.new a
    @point_b = Point.new b
  end

  def to_s
    "#{@point_a.to_s} -> #{@point_b.to_s}"
  end

  def points
    src = @point_a
    des = @point_b

    # slope = (des.y - src.y) / (des.x - src.x)
    # y_intercept = src.y - (src.x * slope)
    # y = mx - b
    if src.x == des.x
      range = src.y < des.y ? (src.y)..(des.y) : (des.y)..(src.y)
      range.each do |y|
        yield Point.new("#{src.x},#{y}")
      end
    elsif src.y == des.y
      range = src.x < des.x ? (src.x)..(des.x) : (des.x)..(src.x)
      range.each do |x|
        yield Point.new("#{x},#{src.y}")
      end
    else
      rangex = src.x < des.x ? (src.x).upto(des.x) : (src.x).downto(des.x)
      rangey = src.y < des.y ? (src.y).upto(des.y) : (src.y).downto(des.y)
      rangex.zip(rangey).each do |x, y|
        yield Point.new("#{x},#{y}")
      end
    end
  end
end

class Point
  attr_reader :x, :y

  def initialize(raw)
    @x, @y = raw.split(",").map { |r| r.to_i }
  end

  def ==(other)
    return self.point_a.x == other.point_a.x &&
             self.point_a.y == other.point_a.y &&
             self.point_b.x == other.point_b.x &&
             self.point_b.y == other.point_b.y
  end

  def !=(other)
    return !(self == other)
  end

  def to_s
    "#{@x},#{@y}"
  end
end

lines = data.map { |line| Line.new line }

# lines.each { |l| puts l.to_s }

max_coords = lines.reduce([0, 0]) { |c, line|
  if line.point_a.x > c[0]
    c[0] = line.point_a.x
  end
  if line.point_b.x > c[0]
    c[0] = line.point_b.x
  end
  if line.point_a.y > c[1]
    c[1] = line.point_a.y
  end
  if line.point_b.y > c[1]
    c[1] = line.point_a.y
  end
  c
}
p max_coords

diagram = Array.new(max_coords[0]) { Array.new(max_coords[1], 0) }

p diagram.flatten.size
p diagram[988 - 1][990 - 1]

# Line.new("510,958 -> 797,671").points { |point| puts point }

lines.each do |line|
  line.points { |point|
    # p point
    diagram[point.x - 1][point.y - 1] += 1
  }
end


puts diagram.flatten.select { |entry| entry >= 2 }.count
