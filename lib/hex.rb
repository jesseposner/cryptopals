# frozen_string_literal: true

require_relative 'numeration'

class Hex
  attr_reader :str

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
          .string_to_integer(string: octet.join,
                                     radix: 16)
       end
  end

  def decode_to_bits
    @_decode_to_bits ||= decode_to_bytes
      .map do |octet|
        binary_str = Numeration
          .integer_to_string(int: octet,
                                 radix: 2)

        until binary_str.length == 8
          binary_str = '0' + binary_str
        end

        binary_str
      end
  end
end
