# frozen_string_literal: true

require_relative 'hex'
require_relative 'b64'

class Numeration
  SUPPORTED_RADIXES = (2..10).to_a + [16, 64]

  def self.convert_int_to_string(int:, radix:)
    raise 'radix not supported' unless SUPPORTED_RADIXES.include?(radix)
    return '0' if int.zero?

    accumulator = []

    until int.zero?
      remainder = int % radix
      remainder = Hex::ALPHABET_BY_INT[remainder] if radix == 16
      remainder = B64::ALPHABET_BY_INT[remainder] if radix == 64

      accumulator << remainder
      int /= radix
    end

    accumulator.reverse.join
  end

  # TODO: move bit/byte converstion to Byte class
  # TODO: this should be convert int to octets and return an array
  # TODO: create zero padding helper method
  def self.convert_int_to_bits(int)
    binary_str = convert_int_to_string(int: int, radix: 2)

    binary_str.prepend('0') until binary_str.length == 8

    binary_str
  end

  def self.convert_string_to_integer(string:, radix:)
    raise 'radix not supported' unless SUPPORTED_RADIXES.include?(radix)

    accumulator = 0
    string
      .reverse
      .each_char
      .with_index do |digit, idx|
        digit = Hex::ALPHABET_BY_STR[digit.upcase] if radix == 16
        digit = B64::ALPHABET_BY_STR[digit.upcase] if radix == 64
        accumulator += exponentiation(radix, idx) * digit.to_i
      end

    accumulator
  end

  # TODO: need to clarify return types
  def self.convert_str_to_bytes(str)
    str.each_char.map { |chr| chr.ord }
  end

  def self.convert_str_to_bits(str)
    self.convert_str_to_bytes(str)
      .map { |byte| self.convert_int_to_bits(byte) }
  end

  def self.exponentiation(base, exponent)
    return 1 if exponent.zero?

    accumulator = base

    (exponent - 1).times { accumulator *= base }

    accumulator
  end
end
