class Calculator
  SEVEN = '7'.freeze
  class << self
    def count_numbers_content_7(n)
      count_range_include_7(one_to_n(n))
    end
    alias g count_numbers_content_7

    private

    def one_to_n(n)
      '1'..n.to_s
    end

    def count_range_include_7(range)
      range.count { |i| i.include?(SEVEN) }
    end
  end
end
