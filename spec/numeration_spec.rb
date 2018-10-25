# frozen_string_literal: true

require 'numeration'

RSpec.describe Numeration do
  describe '::exponentiation' do
    it 'should calculate the correct result' do
      expect(Numeration.exponentiation(4, 8)).to eq(4**8)
    end
  end
end
