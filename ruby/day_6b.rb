data = File.readlines("data/day_6")

state = data[0].split(",").map { |e| e.to_i }.sort.tally
state.default = 0

(1..256).each { |i|
  state.transform_keys! { |k| (k - 1) }
  state[6] += state[-1]
  state[8] += state[-1]
  state[-1] = 0
}

p state.values.sum
