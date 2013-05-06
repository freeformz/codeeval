#!/usr/bin/env ruby

output_number = nil
lines = []

File.open(ARGV[0]).each_line do |line|
  line = line.chomp
  next if line.empty?
  if output_number.nil?
    output_number = line.to_i
  elsif lines.length == 0
    lines.insert(0, line)
  else
    inserted = false
    lines.each_with_index do |item, idx|
      if line.length > item.length
        lines.insert(idx, line)
        inserted = true
        break
      end
    end
    lines << line unless inserted
  end
end

lines.take(output_number).each do |line|
  puts line
end
