# frozen_string_literal: true
require_relative 'numeration'

class B64
  # TODO add B64 padding
  def self.encode(str)
    Numeration
      .convert_str_to_bits(str)
      .join
      .split('')
      .each_slice(6)
      .map(&:join)
      .map do |sextet|
        int = Numeration
          .string_to_integer(string: sextet, radix: 2)
        Numeration
          .integer_to_string(int: int, radix: 64)
       end
      .join
  end
end
