gamma_func = lambda { |state, binary_str|
  binary_str = binary_str.strip
  num = binary_str.to_i(2)
  mask = 1 << (binary_str.size)
  for shift in 1..(binary_str.length)
    mask = mask >> 1
    if state[shift] == nil
      state[shift] = (num & mask) > 0 ? 1 : -1
    else
      state[shift] = (num & mask) > 0 ? state[shift] + 1 : state[shift] - 1
    end
  end
  state
}

lines = File.readlines("data/day_3")
result = lines.each.reduce({}) { |c, n| gamma_func.call(c, n) }

gamma_str = result.each.reduce("") { |c, n|
  k, v = n
  next_digit = v.to_i > 0 ? "1" : "0"
  c + next_digit
}
gamma = gamma_str.to_i(2)
mask = (1..gamma_str.length - 1).reduce(1) { |c, n|
  c = c << 1
  c = c | 1
  c
}
epsilon = ~gamma & mask

p mask
puts (gamma.to_s(2))
puts (epsilon.to_s(2))
puts (gamma)
puts (epsilon)
p gamma * epsilon

def oxygen(sub, gamma_func)
  result = sub.each.reduce({}) { |c, n| gamma_func.call(c, n) }
  mask = 1 << (sub[0].strip.length - 1)
  p mask
  coll = sub.collect { |e|
    e = e.strip.to_i(2)
    if result[1] > 0
      ((e & mask) > 0 ? e : nil)
    else
      ((e & mask) <= 0 ? e : nil)
    end
  }

  comp = coll.compact
  if comp.length == 1
    p "comp"
    return comp
  else
    p "hi"
    return oxygen(comp, gamma_func)
  end
end

puts oxygen(lines, gamma_func)
