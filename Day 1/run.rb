require 'csv'
require 'pry'

class DayOne
  def initialize(filename)
    @filename = filename
    post_initialize
  end

  def count_increased_records
    increased = 0
    data.each_cons(2) do |record|
      increased += 1 if record[0][0].to_i < record[1][0].to_i
    end
    puts "Increased records: #{increased}"
  end

  def count_increased_groups
    increased = 0
    sum = 0
    sum_prev = 0
    data.each_cons(3) do |record|
      sum = record[0][0].to_i + record[1][0].to_i + record[2][0].to_i
      increased += 1 if sum > sum_prev
      sum_prev = sum
    end
    puts "Increased groups of 3: #{increased - 1}"
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
end

DayOne.new('data.csv').count_increased_records
DayOne.new('data.csv').count_increased_groups
