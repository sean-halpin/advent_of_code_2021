class Submarine
  attr_reader :distance, :depth, :aim

  def initialize
    @distance = 0
    @depth = 0
    @aim = 0
  end

  def move(command)
    case command
    when /^(forward) ([0-9].*)$/
      @distance += $2.to_i
    when /^(down) ([0-9].*)$/
      @depth += $2.to_i
    when /^(up) ([0-9].*)$/
      @depth -= $2.to_i
    else
      raise StandardError.new "Unknown Command #{command}"
    end
  end

  def move_v2(command)
    case command
    when /^(forward) ([0-9].*)$/
      @distance += $2.to_i
      @depth += @aim * $2.to_i
    when /^(down) ([0-9].*)$/
      @aim += $2.to_i
    when /^(up) ([0-9].*)$/
      @aim -= $2.to_i
    else
      raise StandardError.new "Unknown Command #{command}"
    end
  end
end

sub = Submarine.new
sub2 = Submarine.new
File.readlines("data/day_2").each { |cmd|
  sub.move cmd.strip
  sub2.move_v2 cmd.strip
}
p (sub.distance * sub.depth)
p (sub2.distance * sub2.depth)
