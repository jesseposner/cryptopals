# frozen_string_literal: true

require_relative '../math/numeration'
require_relative '../encodings/hex'
require_relative '../encodings/byte'

class XOR
  def self.int(int1, int2)
    bits1          = Byte::Integer.new(int1).bits
    bits2          = Byte::Integer.new(int2).bits
    longest_length = [bits1, bits2].map(&:length).max
    padded_bits1   = Byte.zero_pad(bits1, longest_length)
    padded_bits2   = Byte.zero_pad(bits2, longest_length)
    xor_bits       = padded_bits1
                     .chars
                     .map
                     .with_index do |bit1, idx|
                       bit(bit1.to_i, padded_bits2[idx].to_i)
                     end
                     .join

    Numeration.string_to_integer(string: xor_bits,
                                 radix: 2)
  end

  def self.bit(bit1, bit2)
    unless ([bit1, bit2] - [1, 0]).empty?
      raise 'Arguments must be bits (i.e. 1 or 0)'
    end

    bit1 == bit2 ? 0 : 1
  end
end
