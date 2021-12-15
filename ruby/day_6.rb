data = File.readlines("data/day_6")

state = data[0].split(",").map { |e| e.to_i }
p state
(1..80).each { |i|
  p i
  new_fish = 0
  state.map! { |fish|
    days = fish - 1
    if days < 0
      new_fish += 1
      6
    else
      days
    end
  }
  1.upto(new_fish).each { |nf| state.append(8) }
}

p state.size
