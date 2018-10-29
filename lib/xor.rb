# frozen_string_literal: true

require_relative 'numeration'
require_relative 'hex'

class XOR
  def self.fixed(hex_str1, hex_str2)
    hex1 = Hex.new(hex_str1)
    bits1 = hex1.decode_to_bits.join.chars
    hex2 = Hex.new(hex_str2)
    bits2 = hex2.decode_to_bits.join.chars
    xor_bits = bits1.map.with_index { |bit, idx| bit.to_i ^ bits2[idx].to_i }
    xor_bits.each_slice(8).map do |octet|
      int = Numeration
        .string_to_integer(string: octet.join, radix: 2)
      Numeration
        .integer_to_string(int: int, radix: 16)
    end
    .join
  end

  def self.single(str:, chr_int:)
    hex = Hex.new(str.upcase)
    hex_bytes = hex.decode_to_bytes
    hex_bytes.map { |b| self.int_xor(b, chr_int).chr }.join
  end

  def self.int_xor(int1, int2)
    binary1 = Numeration.convert_int_to_bits(int: int1, radix: 2)
    binary2 = Numeration.convert_int_to_bits(int: int2, radix: 2)
    binary1.map.with_index { |bit, idx| self.bit_xor(bit, binary2.chars[idx]) }
  end

  def self.bit_xor(bit1, bit2)
    raise 'Arguments values must be 1 or 0' unless ([bit1, bit2] - [1,0]).empty?

    bit1 == bit2 ? 0 : 1
  end
end
