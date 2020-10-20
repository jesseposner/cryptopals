# frozen_string_literal: true

require 'sets/set1'

RSpec.describe 'Set1' do
  describe 'Challenge 1' do
    let(:hex) { '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d' }
    let(:b64) { 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t' }

    it 'should convert the hex string to base64' do
      expect(Set1.hex_string_to_base64(hex)).to eq(b64)
    end
  end

  describe 'Challenge 2' do
    let(:hex1) { '1c0111001f010100061a024b53535009181c' }
    let(:hex2) { '686974207468652062756c6c277320657965' }
    let(:xor) { '746865206b696420646f6e277420706c6179' }

    it 'should XOR combine two equal-length buffers' do
      expect(Set1.xor_combine_equal_hex_buffers(hex1, hex2)).to eq(xor)
    end
  end

  describe 'Challenge 3' do
    let(:hex) { '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736' }
    let(:message) { "Cooking MC's like a pound of bacon" }

    it 'should decrypt the message' do
      xor_combinations = (0..255).map do |byte|
        Set1.xor_combine_hex_and_single_char(hex, Alphabet::Ascii::CHARACTERS[byte])
      end
      best_scored_combination = Set1.best_score(xor_combinations)

      expect(best_scored_combination).to eq(message)
    end
  end
end
