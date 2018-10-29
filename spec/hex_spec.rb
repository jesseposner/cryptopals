# frozen_string_literal: true

require 'hex'

RSpec.describe Hex do
  let(:hex_str) { '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d' }
  let(:hex_instance) { Hex.new(hex_str) }

  describe '#decode_to_ascii' do
    it 'should decode correctly' do
      expect(hex_instance.decode_to_ascii)
        .to eq("I'm killing your brain like a poisonous mushroom")
    end
  end
end
