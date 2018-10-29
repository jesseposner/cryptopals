# frozen_string_literal: true

require 'numeration'

RSpec.describe Numeration do
  describe '::integer_to_string' do
    it 'should calculate the correct result' do
      described_class::SUPPORTED_RADIXES.each do |radix|
        next if radix == 64

        (0..100).each do |int|
          expect(
            described_class.integer_to_string(int: int,
                                              radix: radix)
          ).to eq(int.to_s(radix))
        end
      end
    end

    context 'when the radix is not supported' do
      it 'should raise an error' do
        expect do
          described_class.integer_to_string(
            int: 1,
            radix: described_class::SUPPORTED_RADIXES.max + 1
          )
        end.to raise_error(StandardError, 'radix not supported')
      end
    end
  end

  describe '::exponentiation' do
    it 'should calculate the correct result' do
      (0..100).each do |base|
        (100..0).each do |exponent|
          expect(
            described_class.exponentiation(base, exponent)
          ).to eq(base**exponent)
        end
      end
    end
  end
end
