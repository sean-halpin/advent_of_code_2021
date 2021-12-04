result = File.readlines("data/day_3").each.reduce({}) { |state, binary_str|
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
