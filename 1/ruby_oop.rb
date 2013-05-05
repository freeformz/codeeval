#!/usr/bin/env ruby

# Encapsulates the divisors for testing 
# Fizz/Buzz
class FizzBuzzChecker

  attr_reader :fizz, :buzz

  def initialize(fizz, buzz)
    @fizz, @buzz = fizz, buzz
  end

  def fizz?(value)
    value % fizz == 0
  end

  def buzz?(value)
    value % buzz == 0
  end

  def fizzbuzz?(value)
    fizz?(value) && buzz?(value)
  end
end

# Given a checker and value present
# F, B, FB or value
class FizzBuzzPresenter
  attr_reader :checker, :value

  def initialize(checker, value)
    @checker, @value = checker, value
  end

  def to_s
    if checker.fizzbuzz?(value)
      "FB"
    elsif checker.fizz?(value)
      "F"
    elsif checker.buzz?(value)
      "B"
    else
      value.to_s
    end
  end
end

# Given a checker and n enumerate the Fizz Buzz Sequence
class FizzBuzzSeries
  include Enumerable

  attr_reader :checker, :n

  def initialize(checker, n)
    @checker, @n = checker, n
  end

  def each
    1.upto(n) do |i|
      yield i, FizzBuzzPresenter.new(checker, i)
    end
  end

  def to_s
    map {|i, fb| fb.to_s}.join(" ")
  end

end

# Reads files in the format of:
# a b n
# a b n
#
# Where a is the fizz divisor
# Where b is the buzz divisor
# Where n in the limit 1.upto(n)
#
# and enumerate a FizzBuzzSeries for each line
class FizzBuzzTestCaseReader
  include Enumerable

  def initialize(file_name)
    @file_name = file_name
  end

  def each
    File.open(@file_name).each_line do |line|
      a,b,n = line.split(" ").map {|s| s.to_i}
      yield FizzBuzzSeries.new(FizzBuzzChecker.new(a,b),n)
    end
  end
end

FizzBuzzTestCaseReader.new(ARGV[0]).each do |fizz_buzz_series|
  puts fizz_buzz_series
end
