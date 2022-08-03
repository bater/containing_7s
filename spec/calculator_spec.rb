require "calculator"

RSpec.describe Calculator do
  describe 'Count of numbers that contain a 7.' do
    it { expect(Calculator.g(7)).to eq(1) }
    it { expect(Calculator.g(20)).to eq(2) }
    it { expect(Calculator.g(70)).to eq(8) }
    it { expect(Calculator.g(100)).to eq(19) }
    it { expect(Calculator.g(1000)).to eq(271) }
  end
end
