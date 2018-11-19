# frozen_string_literal: true

require_relative '../encodings/ordinals/alphabet'

class Numeration
  def self.integer_to_string(int:, radix:)
    return '0' if int.zero?

    accumulator = []

    until int.zero?
      remainder = int % radix
      alphabet  = Alphabet.new(radix)
      symbol    = alphabet.symbol(remainder)

      accumulator << symbol
      int /= radix
    end

    accumulator.reverse.join
  end

  def self.string_to_integer(string:, radix:)
    accumulator = 0
    string
      .reverse
      .each_char
      .with_index do |digit, idx|
        alphabet = Alphabet.new(radix)
        int      = alphabet.integer(digit)

        accumulator += exponentiation(base: radix, exponent: idx) * int
      end

    accumulator
  end

  def self.exponentiation(base:, exponent:)
    return 1 if exponent.zero?

    accumulator = base

    (exponent - 1).times { accumulator *= base }

    accumulator
  end
end
