class Hex
  ALPHABET = {
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
    10 => 'A',
    11 => 'B',
    12 => 'C',
    13 => 'D',
    14 => 'E',
    15 => 'F',
  }

  def self.decode(hex_str)
    hex_str.chars.each_slice(2).map(&:join).map { |b| b.to_i(16).chr }.join
  end
end

class Numeration
  SUPPORTED_RADIXES = (2..10).to_a + [16]

  def self.convert_to_base(int:, radix:)
    raise 'radix not supported' unless SUPPORTED_RADIXES.include?(radix)
    return '0' if int.zero?

    accumulator = []

    until int.zero?
      remainder = int % radix
      remainder = Hex::ALPHABET[remainder] if radix == 16

      accumulator << remainder
      int = int / radix
    end

    accumulator.reverse.join
  end

  def self.exponentiation(base, exponent)
    accumulator = base

    (exponent - 1).times { accumulator *= base }

    accumulator
  end
end
