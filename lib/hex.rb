# frozen_string_literal: true

require_relative 'numeration'

class Hex
  attr_reader :str

  ALPHABET_BY_INT = {
    0 => '0',
    1 => '1',
    2 => '2',
    3 => '3',
    4 => '4',
    5 => '5',
    6 => '6',
    7 => '7',
    8 => '8',
    9 => '9',
    10 => 'a',
    11 => 'b',
    12 => 'c',
    13 => 'd',
    14 => 'e',
    15 => 'f'
  }.freeze

  ALPHABET_BY_STR = ALPHABET_BY_INT.invert.freeze

  def initialize(str)
    @str = str

    decode_to_bytes
    decode_to_ascii
    decode_to_bits
  end

  def decode_to_ascii
    @_decode_to_ascii ||= decode_to_bytes
                          .map(&:chr)
                          .join
  end

  def decode_to_bytes
    @_decode_to_bytes ||= @str
      .chars
      .each_slice(2)
      .map do |octet|
        Numeration
          .convert_string_to_integer(string: octet.join, 
                                     radix: 16)
       end
  end

  def decode_to_bits
    @_decode_to_bits ||= decode_to_bytes
      .map do |byte|
        binary_str = Numeration
          .convert_int_to_string(int: byte, 
                                 radix: 2)

        until binary_str.length == 8
          binary_str = '0' + binary_str
        end

        binary_str
      end
  end
end
