# frozen_string_literal: true

require_relative 'numeration'

class Byte
  def self.zero_pad(string, length)
    padded_string = string.dup

    padded_string.prepend('0') until padded_string.length == length

    padded_string
  end

  class Integer
    attr_reader :int

    def initialize(int)
      @int = int

      octets
      bits
    end

    def octets
      return @_octets if @_octets

      binary_str = Numeration
                   .integer_to_string(int: @int, radix: 2)

      @_octets = binary_str
                 .chars
                 .reverse
                 .each_slice(8)
                 .map { |octet| Byte.zero_pad(octet.reverse, 8).join }
                 .reverse
    end

    def bits
      @_bits ||= octets.join
    end
  end

  class String
    attr_reader :str

    def initialize(str)
      @str = str

      bytes
      octets
    end

    def bytes
      @_bytes ||= @str.each_char.map(&:ord)
    end

    def octets
      @_octets ||= bytes.map { |byte| Integer.new(byte).bits }
    end

    def bits
      @_bits ||= octets.join
    end
  end
end
