data = File.readlines("data/day_1")

total = 0
data.each.reduce(0) { |prev, n|
  if n.strip.to_i > prev and prev != 0
    total += 1
  end
  n.strip.to_i
}
p total

total = 0
data.map { |d| d.strip.to_i }.
  each_cons(3).to_a.
  reduce(nil) { |prev, elems|
  if prev != nil and elems.inject(:+) > prev
    total += 1
  end
  elems.inject(:+)
}
p total
