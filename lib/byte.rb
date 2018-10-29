require_relative 'numeration'

class Byte
  # TODO: move bit/byte converstion to Byte class
  # TODO: this should be convert int to octets and return an array
  # TODO: create zero padding helper method
  def self.convert_int_to_bits(int)
    binary_str = Numeration.integer_to_string(int: int, radix: 2)

    binary_str.prepend('0') until binary_str.length == 8

    binary_str
  end

  def convert_int_to_octets(int)
  end

  # TODO: need to clarify return types
  def self.convert_str_to_bytes(str)
    str.each_char.map { |chr| chr.ord }
  end

  def self.convert_str_to_bits(str)
    self.convert_str_to_bytes(str)
      .map { |byte| self.convert_int_to_bits(byte) }
  end
end
