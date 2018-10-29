# frozen_string_literal: true

require 'hex'

RSpec.describe Hex do
  let(:hex_str) { '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d' }
  let(:hex_instance) { Hex.new(hex_str) }

  describe '#ascii' do
    it 'should decode correctly' do
      expect(hex_instance.ascii)
        .to eq("I'm killing your brain like a poisonous mushroom")
    end
  end

  describe '#bytes' do
    it 'should decode correctly' do
      expect(hex_instance.bytes)
        .to eq([73, 39, 109, 32, 107, 105, 108, 108, 105, 110, 103, 32,
                121, 111, 117, 114, 32, 98, 114, 97, 105, 110, 32, 108,
                105, 107, 101, 32, 97, 32, 112, 111, 105, 115, 111, 110,
                111, 117, 115, 32, 109, 117, 115, 104, 114, 111, 111, 109])
    end
  end

  describe '#bits' do
    it 'should decode correctly' do
      expect(hex_instance.bits)
        .to eq(%w[01001001 00100111 01101101 00100000 01101011 01101001
                  01101100 01101100 01101001 01101110 01100111 00100000
                  01111001 01101111 01110101 01110010 00100000 01100010
                  01110010 01100001 01101001 01101110 00100000 01101100
                  01101001 01101011 01100101 00100000 01100001 00100000
                  01110000 01101111 01101001 01110011 01101111 01101110
                  01101111 01110101 01110011 00100000 01101101 01110101
                  01110011 01101000 01110010 01101111 01101111 01101101])
    end
  end
end
