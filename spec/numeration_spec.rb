# frozen_string_literal: true

require 'math/numeration'

RSpec.describe Numeration do
  describe '::integer_to_string' do
    it 'should calculate the correct result' do
      Alphabet::Bases::SUPPORTED_RADIXES.each do |radix|
        next if radix == 64

        (0..1000).each do |int|
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
            radix: Alphabet::Bases::SUPPORTED_RADIXES.max + 1
          )
        end.to raise_error(StandardError, 'radix not supported')
      end
    end
  end

  describe '::string_to_integer' do
    it 'should calculate the correct result' do
      Alphabet::Bases::SUPPORTED_RADIXES.each do |radix|
        next if radix == 64

        (0..1000).each do |int|
          expect(
            described_class.string_to_integer(string: int.to_s(radix),
                                              radix: radix)
          ).to eq(int.to_s(radix).to_i(radix))
        end
      end
    end
  end

  describe '::exponentiation' do
    it 'should calculate the correct result' do
      (0..100).each do |base|
        (0..100).to_a.reverse.lazy.each do |exponent|
          expect(
            described_class.exponentiation(base: base, exponent: exponent)
          ).to eq(base**exponent)
        end
      end
    end
  end
end
