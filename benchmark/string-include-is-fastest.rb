require "benchmark/ips"

TEST_STR = '17'.freeze
SEVEN = '7'.freeze
REGEX = /7/

Benchmark.ips do |x|
  # Fastest
  x.report("String#include?") { TEST_STR.include?(SEVEN)}
  x.report("String#index") { TEST_STR.index(SEVEN) }
  x.report("Regexp#match?") { REGEX.match?(TEST_STR) }
  x.report("String#[]") { TEST_STR[SEVEN] }
  x.report("Regexp#match") { REGEX.match(TEST_STR) }
  x.report("String#match") { TEST_STR.match(REGEX) }
  # Slowest
  x.compare!
end