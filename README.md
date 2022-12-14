# Contaning 7s

Let g(N) be the count of numbers that contain a 7 when you write out all the numbers from 1 to N.

## Expected result:
- g(7) = 1
- g(20) = 2
- g(70) = 8
- g(100) = 19

## Question 1. What is g(1000)?
It's 271, confirm the result [here](https://github.com/bater/containing_7s/blob/master/spec/calculator_spec.rb#L9).

## Question 2. Write a computer program to compute g(N).
It can be done by one line of code.
```rb
def count_numbers_content_7(n)
  ('1'..n.to_s).count { |i| i.include?(SEVEN) }
end
```
> **Note**
> This method might be refactored later but the compute logic remain the same.

We can split this as two part. Firstly, I create a `range` according to given max number N, which is `('1'..n.to_s)`.

I make a `String` range instead of `Integer` for the next step.

Secondly, I count the numbers which content 7 by `Range#count`, it inherit from [Enumerable#count](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-count).

## Make small things
I'd like to explian my design thinking about my code.

Bascially, just try to **make it small**, make some small classes and small methods and keep it simple. I got this idea from RailsConf 2014 [All the Little Things by Sandi Metz](https://youtu.be/8bZh5LMaSmE), and I think this is one of my favorite conf talks.

In this case, I can do it with one single line.
```rb
def count_numbers_content_7(n)
  ('1'..n.to_s).count { |i| i.include?(SEVEN) }
end
```
But consider not all the team member have the same chain methods preference, so I think it might worth to write as two simple privte method:
```rb
def count_numbers_content_7(n)
  count_range_include_7(one_to_n(n))
end

private

def one_to_n(n)
  '1'..n.to_s
end

def count_range_include_7(range)
  range.count { |i| i.include?(SEVEN) }
end
```
In this style, the method is small and simple enough that not even need any comment or document, **the code explain itself**. And I believe the best document is readable code.

But in the end, after I added the `String#include_7?` on `core_ext.rb`, I think it's too simple that should be one line again. So this part become just an idea sharing only.

In my mind, the proper line of code comparison would be like:
```rb
# It's long enough to consider split as minor methods, because it's more than two concepts.
def count_numbers_content_7(n)
  ('1'..n.to_s).count { |i| i.include?(SEVEN) }
end

# It's short and clean enough to be one line. Only two concepts.
def count_numbers_include_7(n)
  ('1'..n.to_s).count(&:include_7?)
end
```
It's hard to explain the measurement of concept deeply, but what I could say is about **Code Smell**.

## Fast Ruby
Inspired by [fast-ruby](https://github.com/fastruby/fast-ruby). When I have more than one option to implement the code and logic, I will choose faster one.

### `String#include?` is fasted
```
$ ruby benchmark/string-include-is-fastest.rb

Warming up --------------------------------------
     String#include?   766.488k i/100ms
       Regexp#match?   612.661k i/100ms
           String#[]   530.661k i/100ms
        Regexp#match   100.172k i/100ms
        String#match    96.813k i/100ms
        String#index   697.836k i/100ms
Calculating -------------------------------------
     String#include?      7.580M (?? 3.9%) i/s -     38.324M in   5.064562s
       Regexp#match?      6.559M (?? 4.3%) i/s -     33.084M in   5.055599s
           String#[]      6.319M (?? 3.1%) i/s -     31.840M in   5.044475s
        Regexp#match      1.022M (?? 6.8%) i/s -      5.109M in   5.026413s
        String#match    972.095k (?? 6.0%) i/s -      4.937M in   5.097848s
        String#index      6.783M (?? 8.3%) i/s -     34.194M in   5.094559s

Comparison:
     String#include?:  7579583.8 i/s
        String#index:  6783165.5 i/s - same-ish: difference falls within error
       Regexp#match?:  6559136.3 i/s - 1.16x  (?? 0.00) slower
           String#[]:  6318549.1 i/s - 1.20x  (?? 0.00) slower
        Regexp#match:  1021948.6 i/s - 7.42x  (?? 0.00) slower
        String#match:   972095.4 i/s - 7.80x  (?? 0.00) slower
```
[code](benchmark/string-include-is-fastest.rb)

### `Range#count` is slightly faster
```
$ ruby benchmark/range-count-is-faster.rb

Warming up --------------------------------------
         Range#count    19.230k i/100ms
         Array#count    18.997k i/100ms
Calculating -------------------------------------
         Range#count    193.023k (?? 2.0%) i/s -    980.730k in   5.083081s
         Array#count    190.849k (?? 1.2%) i/s -    968.847k in   5.077233s

Comparison:
         Range#count:   193022.7 i/s
         Array#count:   190848.9 i/s - same-ish: difference falls within error
```
[code](benchmark/range-count-is-faster.rb)