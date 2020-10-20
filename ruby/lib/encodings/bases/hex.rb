# frozen_string_literal: true

require_relative '../../math/numeration'
require_relative '../ordinals/alphabet'
require_relative '../ordinals/byte'

class Hex
  attr_reader :str

  def initialize(str)
    @str = str
  end

  def ascii
    @_ascii ||= bytes
                .map { |byte| Alphabet::Ascii::CHARACTERS[byte] }
                .join
  end

  def bytes
    @_bytes ||= @str
                .chars
                .each_slice(2)
                .map do |octet|
                  Numeration
                    .string_to_integer(string: octet.join,
                                       radix: 16)
                end
  end

  def octets
    @_octets ||= bytes.map { |byte| Byte::Integer.new(byte).bits }
  end

  def bits
    @_bits ||= octets.join
  end
end
