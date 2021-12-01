total = 0
File.readlines("data/day_1").each.reduce(0) { |prev, n|
  if n.strip.to_i > prev and prev != 0
    total += 1
  end
  n.strip.to_i
}
p total
