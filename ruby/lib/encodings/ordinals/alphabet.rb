# frozen_string_literal: true

class Alphabet
  def self.ordinal_positions(characters)
    characters
      .map
      .with_index { |chr, ord| [chr, ord] }
      .to_h
      .freeze
  end

  class Bases
    attr_reader :radix

    SUPPORTED_RADIXES = (2..10).to_a + [16, 64]

    def initialize(radix)
      raise 'radix not supported' unless SUPPORTED_RADIXES.include?(radix)

      @radix = radix
    end

    def symbol(integer)
      symbol = case @radix
               when 16
                 Hex::CHARACTERS[integer]
               when 64
                 B64::CHARACTERS[integer]
               else
                 integer
               end

      symbol.to_s
    end

    def integer(symbol)
      integer = case @radix
                when 16
                  Hex::ORDINAL_POSITIONS[symbol]
                when 64
                  B64::ORDINAL_POSITIONS[symbol]
                else
                  symbol
                end

      integer.to_i
    end

    class B64
      CHARACTERS = %w[
        A B C D E F G H I J K L M N O P Q R S T U
        V W X Y Z a b c d e f g h i j k l m n o p
        q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 + /
      ].freeze

      ORDINAL_POSITIONS = Alphabet.ordinal_positions(CHARACTERS)
    end

    class Hex
      CHARACTERS = %w[
        0 1 2 3 4 5 6 7 8 9 a b c d e f
      ].freeze

      ORDINAL_POSITIONS = Alphabet.ordinal_positions(CHARACTERS)
    end
  end

  class Ascii
    LETTER_FREQUENCY_SCORES = {
      'A' => 8, 'B' => 1, 'C' => 3, 'D' => 4, 'E' => 13, 'F' => 2,
      'G' => 2, 'H' => 6, 'I' => 7, 'J' => 1, 'K' => 1, 'L' => 4,
      'M' => 2, 'N' => 7, 'O' => 8, 'P' => 2, 'Q' => 1, 'R' => 6,
      'S' => 6, 'T' => 9, 'U' => 3, 'V' => 1, 'W' => 2, 'X' => 1,
      'Y' => 2, 'Z' => 1, ' ' => 13
    }.freeze

    CHARACTERS = %W[
      \x00 \x01 \x02 \x03 \x04 \x05 \x06 \a \b \t \n
      \v \f \r \x0E \x0F \x10 \x11 \x12 \x13 \x14 \x15
      \x16 \x17 \x18 \x19 \x1A \e \x1C \x1D \x1E \x1F
      #{' '} ! " # $ % & ' ( ) * + , - . / 0 1 2 3 4 5
      6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N
      O P Q R S T U V W X Y Z [ \\ ] ^ _ ` a b c d e f
      g h i j k l m n o p q r s t u v w x y z { | } ~
      \x7F \x80 \x81 \x82 \x83 \x84 \x85 \x86 \x87 \x88
      \x89 \x8A \x8B \x8C \x8D \x8E \x8F \x90 \x91 \x92
      \x93 \x94 \x95 \x96 \x97 \x98 \x99 \x9A \x9B \x9C
      \x9D \x9E \x9F \xA0 \xA1 \xA2 \xA3 \xA4 \xA5 \xA6
      \xA7 \xA8 \xA9 \xAA \xAB \xAC \xAD \xAE \xAF \xB0
      \xB1 \xB2 \xB3 \xB4 \xB5 \xB6 \xB7 \xB8 \xB9 \xBA
      \xBB \xBC \xBD \xBE \xBF \xC0 \xC1 \xC2 \xC3 \xC4
      \xC5 \xC6 \xC7 \xC8 \xC9 \xCA \xCB \xCC \xCD \xCE
      \xCF \xD0 \xD1 \xD2 \xD3 \xD4 \xD5 \xD6 \xD7 \xD8
      \xD9 \xDA \xDB \xDC \xDD \xDE \xDF \xE0 \xE1 \xE2
      \xE3 \xE4 \xE5 \xE6 \xE7 \xE8 \xE9 \xEA \xEB \xEC
      \xED \xEE \xEF \xF0 \xF1 \xF2 \xF3 \xF4 \xF5 \xF6
      \xF7 \xF8 \xF9 \xFA \xFB \xFC \xFD \xFE \xFF
    ].map { |chr| chr.dup.force_encoding('ASCII-8BIT') }.freeze

    ORDINAL_POSITIONS = Alphabet.ordinal_positions(CHARACTERS)
  end
end
