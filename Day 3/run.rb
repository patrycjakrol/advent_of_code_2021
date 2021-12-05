require 'csv'
require 'pry'

class DayThree
  def initialize(filename)
    @filename = filename
    post_initialize
  end

  def calculate_gamma_rate
    digit = 0
    gamma_rate = ""
    while digit < 12
      gamma_rate += calculate_dominant_digit(digit)
      digit += 1
    end
    puts calculate_power_consumption(gamma_rate)
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

  def calculate_dominant_digit(digit)
    zeros = 0
    ones = 1
    data.each do |rate|
      zeros += 1 if rate[0].split('')[digit] == '0'
      ones += 1 if rate[0].split('')[digit] == '1'
    end
    zeros > ones ? "0" : "1"
  end

  def calculate_epsilon_rate(gamma_rate)
    epsilon_rate = ""
    gamma_rate.split('').each do |digit|
      epsilon_rate += '0' if digit == '1'
      epsilon_rate += '1' if digit == '0'
    end
    epsilon_rate
  end

  def calculate_power_consumption(gamma_rate)
    epsilon_rate = calculate_epsilon_rate(gamma_rate)
    epsilon_rate.to_i(2) * gamma_rate.to_i(2)
  end
end

DayThree.new('data.csv').calculate_gamma_rate
