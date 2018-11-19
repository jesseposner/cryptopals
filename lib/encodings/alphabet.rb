# frozen_string_literal: true

class Alphabet
  SUPPORTED_RADIXES       = (2..10).to_a + [16, 64]
  LETTER_FREQUENCY_SCORES = {
    A:   8,
    B:   1,
    C:   3,
    D:   4,
    E:   13,
    F:   2,
    G:   2,
    H:   6,
    I:   7,
    J:   1,
    K:   1,
    L:   4,
    M:   2,
    N:   7,
    O:   8,
    P:   2,
    Q:   1,
    R:   6,
    S:   6,
    T:   9,
    U:   3,
    V:   1,
    W:   2,
    X:   1,
    Y:   2,
    Z:   1,
    " ": 13
  }.freeze

  attr_reader :radix

  def initialize(radix)
    raise 'radix not supported' unless SUPPORTED_RADIXES.include?(radix)

    @radix = radix
  end

  def symbol(integer)
    symbol = case @radix
             when 16
               Hex::ALPHABET_BY_INT[integer]
             when 64
               B64::ALPHABET_BY_INT[integer]
             else
               integer
             end

    symbol.to_s
  end

  def integer(symbol)
    integer = case @radix
              when 16
                Hex::ALPHABET_BY_STR[symbol]
              when 64
                B64::ALPHABET_BY_STR[symbol]
              else
                symbol
              end

    integer.to_i
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
      63 => '/'
    }.freeze

    ALPHABET_BY_STR = ALPHABET_BY_INT.invert.freeze
  end

  class Hex
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
      10 => 'a',
      11 => 'b',
      12 => 'c',
      13 => 'd',
      14 => 'e',
      15 => 'f'
    }.freeze

    ALPHABET_BY_STR = ALPHABET_BY_INT.invert.freeze
  end

  private_constant :B64, :Hex
end
