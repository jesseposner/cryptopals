# frozen_string_literal: true

require_relative '../../math/numeration'
require_relative '../ordinals/byte'

class B64
  # TODO: add B64 padding
  class Encode
    def self.bits(str)
      str
        .chars
        .each_slice(6)
        .map do |sextet|
          int = Numeration
                .string_to_integer(string: sextet.join, radix: 2)
          Numeration
            .integer_to_string(int: int, radix: 64)
        end
        .join
    end

    def self.bytes(arr)
      bits = arr
             .map { |byte| Byte::Integer.new(byte).bits }
             .join

      bits(bits)
    end

    def self.ascii(str)
      bits = Byte::String.new(str).bits

      bits(bits)
    end
  end
end
