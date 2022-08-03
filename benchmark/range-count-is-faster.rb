require "benchmark/ips"

SEVEN = '7'.freeze

Benchmark.ips do |x|
  x.report("Range#count") { ('1'..'10').count { |i| i.include?(SEVEN) }}
  x.report("Array#count") { ('1'..'10').to_a.count { |i| i.include?(SEVEN) }}
  x.compare!
end