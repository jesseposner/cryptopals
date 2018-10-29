# frozen_string_literal: true

require_relative 'numeration'
require_relative 'byte'

class B64
  # TODO: add B64 padding
  def self.encode_ascii(str)
    Byte::String
      .new(str)
      .bits
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
end
