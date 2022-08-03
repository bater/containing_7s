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
We can split this as two part. Firstly, I create a `range` according to given max number N, which is `('1'..n.to_s)`.

I make a `String` range instead of `Integer` for the next step.

Secondly, I count the numbers which content 7 by `Range#count`, it inherit from [Enumerable#count](https://ruby-doc.org/core-2.7.1/Enumerable.html#method-i-count).