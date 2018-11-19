# frozen_string_literal: true

require 'encodings/b64'

RSpec.describe B64 do
  describe '::Encode' do
    let(:ascii_str) { "I'm killing your brain like a poisonous mushroom" }
    let(:byte_arr) { [73, 39, 109, 32, 107, 105, 108, 108, 105, 110, 103, 32, 121, 111, 117, 114, 32, 98, 114, 97, 105, 110, 32, 108, 105, 107, 101, 32, 97, 32, 112, 111, 105, 115, 111, 110, 111, 117, 115, 32, 109, 117, 115, 104, 114, 111, 111, 109] }
    let(:bit_str) { '010010010010011101101101001000000110101101101001011011000110110001101001011011100110011100100000011110010110111101110101011100100010000001100010011100100110000101101001011011100010000001101100011010010110101101100101001000000110000100100000011100000110111101101001011100110110111101101110011011110111010101110011001000000110110101110101011100110110100001110010011011110110111101101101' }
    let(:expected_encoding) { 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t' }

    describe '::bits' do
      it 'should encode correctly' do
        expect(described_class::Encode.bits(bit_str))
          .to eq(expected_encoding)
      end
    end

    describe '::bytes' do
      it 'should encode correctly' do
        expect(described_class::Encode.bytes(byte_arr))
          .to eq(expected_encoding)
      end
    end

    describe '::ascii' do
      it 'should encode correctly' do
        expect(described_class::Encode.ascii(ascii_str))
          .to eq(expected_encoding)
      end
    end
  end
end
