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

=begin
ruby benchmark.rb

Warming up --------------------------------------
     String#include?   766.488k i/100ms
       Regexp#match?   612.661k i/100ms
           String#[]   530.661k i/100ms
        Regexp#match   100.172k i/100ms
        String#match    96.813k i/100ms
        String#index   697.836k i/100ms
Calculating -------------------------------------
     String#include?      7.580M (± 3.9%) i/s -     38.324M in   5.064562s
       Regexp#match?      6.559M (± 4.3%) i/s -     33.084M in   5.055599s
           String#[]      6.319M (± 3.1%) i/s -     31.840M in   5.044475s
        Regexp#match      1.022M (± 6.8%) i/s -      5.109M in   5.026413s
        String#match    972.095k (± 6.0%) i/s -      4.937M in   5.097848s
        String#index      6.783M (± 8.3%) i/s -     34.194M in   5.094559s

Comparison:
     String#include?:  7579583.8 i/s
        String#index:  6783165.5 i/s - same-ish: difference falls within error
       Regexp#match?:  6559136.3 i/s - 1.16x  (± 0.00) slower
           String#[]:  6318549.1 i/s - 1.20x  (± 0.00) slower
        Regexp#match:  1021948.6 i/s - 7.42x  (± 0.00) slower
        String#match:   972095.4 i/s - 7.80x  (± 0.00) slower
=end