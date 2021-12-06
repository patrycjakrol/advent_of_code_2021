# frozen_string_literal: true

def call(data)
  counter = 0
  (data.length - 1).times do |i|
    counter += 1 if data[i + 1] > data[i]
  end
  counter
end

data = File.read('inputs/day1.txt').split("\n").map(&:to_i)
p call(data)