require 'csv'
require 'pry'

class DayTwo
  def initialize(filename)
    @filename = filename
    post_initialize
  end

  def calculate_position
    position_x = 0
    position_y = 0

    data.each do |move|
      direction = move[0].split(' ')[0]
      value = move[0].split(' ')[1].to_i

      value = 0 - value if direction == 'up'

      position_x += value if direction == 'forward'
      position_y += value if direction == 'up' or direction == 'down'
    end
    puts calculate_product_of_position(position_x, position_y)
  end

  def calculate_advanced_position
    position_x = 0
    position_y = 0
    aim = 0

    data.each do |move|
      direction = move[0].split(' ')[0]
      value = move[0].split(' ')[1].to_i

      value = 0 - value if direction == 'up'
      aim += value if direction == 'up' or direction == 'down'

      position_x += value if direction == 'forward'
      position_y += value * aim if direction == 'forward'
    end
    puts calculate_product_of_position(position_x, position_y)
  end

  private

  attr_reader :filename, :data

  def post_initialize
    unless File.exist?(filename)
      puts "Given file doesn't exist."
      exit
    end

    content = File.read(filename)
    @data = CSV.parse(content)
  end

  def calculate_product_of_position(position_x, position_y)
    position_x * position_y
  end
end

DayTwo.new('data.csv').calculate_position
DayTwo.new('data.csv').calculate_advanced_position