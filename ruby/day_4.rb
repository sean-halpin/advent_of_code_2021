require "set"

data = File.readlines("data/day_4")

class BingoCard
  @@drawn = Set.new

  def initialize(numbers)
    @rows = []
    for row in numbers.each
      @rows.push(Set.new(row.split(" ")))
    end
  end

  def self.draw_number(num)
    @@drawn.add num
  end

  def bingo_value(row)
    intersect = @@drawn.intersection(row)
    if intersect.size == 5
      p "BINGO" + intersect.to_s
      sum_unhit = @rows.map { |s| s.to_a }.flatten.to_set.subtract(@@drawn).to_a.reduce(0) { |c, i| c + i.to_i }
      p "UNHIT: " + sum_unhit.to_s
      return sum_unhit
    else
      return nil
    end
  end

  def check_bingo
    for col in @rows.map { |r| r.to_a }.transpose
      val = bingo_value(col)
      if val != nil
        return val
      end
    end
    for row in @rows
      val = bingo_value(row)
      if val != nil
        return val
      end
    end
    nil
  end
end

cards = []
data.slice(1..-1)
  .map { |e| e.strip }
  .select { |e| e != "" }
  .each_slice(5) { |e| cards.push(BingoCard.new(e)) }

numbers_drawn = data[0].split(",")

winning_number = 0
winning_line_sum = 0
numbers_drawn.each { |drawn|
  p drawn
  BingoCard.draw_number drawn
  cards.each { |card|
    val = card.check_bingo
    if val != nil
      winning_line_sum = val
    end
  }.compact
  if winning_line_sum > 0
    winning_number = drawn
    break
  end
}

p winning_line_sum
p winning_number
p "bingo : " + (winning_line_sum.to_i * winning_number.to_i).to_s
