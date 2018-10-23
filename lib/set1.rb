# TODO: write tests
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
    10 => 'A',
    11 => 'B',
    12 => 'C',
    13 => 'D',
    14 => 'E',
    15 => 'F',
  }

  ALPHABET_BY_STR = ALPHABET_BY_INT.invert

  def initialize(str)
    @str = str

    decode_to_bytes
    decode_to_ascii
    decode_to_bits
  end

  def decode_to_ascii
    @_decode_to_ascii ||= decode_to_bytes
      .map { |byte| byte.chr }
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

class B64
  ALPHABET_BY_INT = {
    0 => 'A',
    1 => 'B',
    2 => 'C',
    3 => 'D',
    4 => 'E',
    5 => 'F',
    6 => 'G',
    7 => 'H',
    8 => 'I',
    9 => 'J',
    10 => 'K',
    11 => 'L',
    12 => 'M',
    13 => 'N',
    14 => 'O',
    15 => 'P',
    16 => 'Q',
    17 => 'R',
    18 => 'S',
    19 => 'T',
    20 => 'U',
    21 => 'V',
    22 => 'W',
    23 => 'X',
    24 => 'Y',
    25 => 'Z',
    26 => 'a',
    27 => 'b',
    28 => 'c',
    29 => 'd',
    30 => 'e',
    31 => 'f',
    32 => 'g',
    33 => 'h',
    34 => 'i',
    35 => 'j',
    36 => 'k',
    37 => 'l',
    38 => 'm',
    39 => 'n',
    40 => 'o',
    41 => 'p',
    42 => 'q',
    43 => 'r',
    44 => 's',
    45 => 't',
    46 => 'u',
    47 => 'v',
    48 => 'w',
    49 => 'x',
    50 => 'y',
    51 => 'z',
    52 => '0',
    53 => '1',
    54 => '2',
    55 => '3',
    56 => '4',
    57 => '5',
    58 => '6',
    59 => '7',
    60 => '8',
    61 => '9',
    62 => '+',
    63 => '/',
  }

  ALPHABET_BY_STR = ALPHABET_BY_INT.invert

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
          .convert_string_to_integer(string: sextet, radix: 2)
        Numeration
          .convert_int_to_string(int: int, radix: 64)
       end
      .join
  end
end

class XOR
  def self.fixed(hex_str1, hex_str2)
    hex1 = Hex.new(hex_str1)
    bits1 = hex1.decode_to_bits.join.chars
    hex2 = Hex.new(hex_str2)
    bits2 = hex2.decode_to_bits.join.chars
    xor_bits = bits1.map.with_index { |bit, idx| bit.to_i ^ bits2[idx].to_i }
    xor_bits.each_slice(8).map do |octet|
      int = Numeration
        .convert_string_to_integer(string: octet.join, radix: 2)
      Numeration
        .convert_int_to_string(int: int, radix: 16)
    end
    .join
  end

  def self.single(str:, chr_int:)
    hex = Hex.new(str.upcase)
    hex_bytes = hex.decode_to_bytes
    hex_bytes.map { |b| self.int_xor(b, chr_int).chr }.join
  end

  def self.int_xor(int1, int2)
    binary1 = Numeration.convert_int_to_bits(int: int1, radix: 2)
    binary2 = Numeration.convert_int_to_bits(int: int2, radix: 2)
    binary1.map.with_index { |bit, idx| self.bit_xor(bit, binary2.chars[idx]) }
  end

  def self.bit_xor(bit1, bit2)
    raise 'Arguments values must be 1 or 0' unless ([bit1, bit2] - [1,0]).empty?

    bit1 == bit2 ? 0 : 1
  end
end

class Numeration
  SUPPORTED_RADIXES = (2..10).to_a + [16, 64]

  def self.convert_int_to_string(int:, radix:)
    raise 'radix not supported' unless SUPPORTED_RADIXES.include?(radix)
    return '0' if int.zero?

    accumulator = []

    until int.zero?
      remainder = int % radix
      remainder = Hex::ALPHABET_BY_INT[remainder] if radix == 16
      remainder = B64::ALPHABET_BY_INT[remainder] if radix == 64

      accumulator << remainder
      int = int / radix
    end

    accumulator.reverse.join
  end

  def self.convert_int_to_bits(int)
    binary_str = self.convert_int_to_string(int: int, radix: 2)

    until binary_str.length == 8
      binary_str = '0' + binary_str
    end

    binary_str
  end

  def self.convert_string_to_integer(string:, radix:)
    raise 'radix not supported' unless SUPPORTED_RADIXES.include?(radix)

    accumulator = 0
    string
      .reverse
      .each_char
      .with_index do |digit, idx|
        digit = Hex::ALPHABET_BY_STR[digit.upcase] if radix == 16
        digit = B64::ALPHABET_BY_STR[digit.upcase] if radix == 64
        accumulator += exponentiation(radix, idx) * digit.to_i
      end

    accumulator
  end

  # TODO: need to clarify return types
  def self.convert_str_to_bytes(str)
    str.each_char.map { |chr| chr.ord }
  end

  def self.convert_str_to_bits(str)
    self.convert_str_to_bytes(str)
      .map { |byte| self.convert_int_to_bits(byte) }
  end

  def self.exponentiation(base, exponent)
    return 1 if exponent.zero?

    accumulator = base

    (exponent - 1).times { accumulator *= base }

    accumulator
  end
end
