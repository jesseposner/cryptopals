# frozen_string_literal: true

require_relative 'numeration'

class Byte
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
                 .map { |octet| zero_pad_octet(octet.reverse).join }
                 .reverse
    end

    def bits
      @_bits ||= octets.join
    end

    private

    def zero_pad_octet(octet)
      octet.prepend('0') until octet.length == 8

      octet
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
