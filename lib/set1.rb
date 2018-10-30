# frozen_string_literal: true

require_relative 'hex'
require_relative 'b64'
require_relative 'xor'
require_relative 'numeration'
require_relative 'alphabet'

class Set1
  def self.hex_string_to_base64(hex)
    hex_bytes = Hex.new(hex).bytes

    B64::Encode.bytes(hex_bytes)
  end

  def self.xor_combine_equal_hex_buffers(buffer1, buffer2)
    hex1_bytes = Hex.new(buffer1).bytes
    hex2_bytes = Hex.new(buffer2).bytes

    hex1_bytes.map.with_index do |hex1_byte, idx|
      xor_int = XOR.int(hex1_byte, hex2_bytes[idx])
      Numeration.integer_to_string(int: xor_int, radix: 16)
    end.join
  end

  def self.xor_combine_hex_and_single_char(hex, char)
    hex_bytes = Hex.new(hex).bytes
    char_byte = char.ord
    xor_hex   = hex_bytes.map do |byte|
      xor_int = XOR.int(byte, char_byte)
      Numeration.integer_to_string(int: xor_int, radix: 16)
    end.join

    Hex.new(xor_hex).ascii
  end

  def self.best_score(string_arr)
    string_arr.max_by { |str| score_string(str) }
  end

  def self.score_string(str)
    str
      .chars
      .map { |char| Alphabet::LETTER_FREQUENCY_SCORES[char.to_sym.upcase] || 0 }
      .sum
  end
end
