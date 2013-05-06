#!/usr/bin/env ruby

require 'delegate'

class SolutionPresenter

  attr_reader :tcr

  def initialize(tcr)
    @tcr = tcr
  end

  def to_s
    tcr.to_a.take(tcr.output_number).join("\n")
  end
end

class LengthSortedArray < DelegateClass(Array)

  def initialize
    @ary = Array.new
    super(@ary)
  end

  def <<(elem)
    if @ary.length == 0
      insert(0, elem)
    else
      inserted = false
      @ary.each_with_index do |item, idx|
        if elem.length > item.length
          @ary.insert(idx, elem)
          inserted = true
          break
        end
      end
      @ary.<<(elem) unless inserted
    end
    self
  end

end

class TestCaseReader

  attr_reader :output_number, :file_name

  def initialize(file_name)
    @file_name = file_name
    @output_number = nil
  end

  def each_line
    File.open(file_name).each_line do |line|
      line = line.chomp
      next if line.empty?
      if output_number.nil?
        @output_number = line.to_i
      else
        yield line
      end
    end
  end

  def to_a
    lines = LengthSortedArray.new
    each_line do |line|
      lines << line
    end
    lines
  end

end

puts SolutionPresenter.new(TestCaseReader.new(ARGV[0]))

