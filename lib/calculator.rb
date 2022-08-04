require 'core_ext'

class Calculator
  class << self
    def count_numbers_include_7(n)
      ('1'..n.to_s).count(&:include_7?)
    end
    alias g count_numbers_include_7
  end
end
