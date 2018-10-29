# frozen_string_literal: true

require_relative 'numeration'

class Hex
  attr_reader :str

  def initialize(str)
    @str = str

    bytes
    ascii
    bits
  end

  def ascii
    @_ascii ||= bytes
                .map(&:chr)
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

  def bits
    @_bits ||= bytes.map { |byte| Byte::Integer.new(byte).bits }
  end
end
