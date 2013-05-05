#!/usr/bin/env ruby

File.open(ARGV[0]).each_line do |line|
  a,b,n = line.split(" ").map { |i| i.to_i }
  1.upto(n) do |iter|
    if iter % a == 0
     if iter % b == 0
       print "FB"
     else
       print "F"
     end
    elsif iter % b == 0
      print "B"
    else
      print iter
    end
    print " " unless iter == n
  end
  puts
end



