class Calculator
  SEVEN = '7'.freeze
  class << self
    def count_numbers_content_7(n)
      ('1'..n.to_s).count { |i| i.include?(SEVEN) }
    end
    alias g count_numbers_content_7
  end
end
