# frozen_string_literal: true

require 'byte'

RSpec.describe Byte do
  describe '::Integer' do
    let(:int) { 22_141_245 }
    let(:integer_instance) { described_class::Integer.new(int) }

    describe '#octets' do
      it 'should calculate the correct result' do
        expect(integer_instance.octets)
          .to eq(%w[00000001 01010001 11011001 00111101])
      end
    end

    describe '#bits' do
      it 'should calculate the correct result' do
        expect(integer_instance.bits)
          .to eq('00000001010100011101100100111101')
      end
    end
  end

  describe '::String' do
    let(:str) { 'Hello World!' }
    let(:string_instance) { described_class::String.new(str) }

    describe '#bytes' do
      it 'should calculate the correct result' do
        expect(string_instance.bytes)
          .to eq([72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33])
      end
    end

    describe '#octets' do
      it 'should calculate the correct result' do
        expect(string_instance.octets)
          .to eq(%w[01001000 01100101 01101100 01101100 01101111 00100000 01010111 01101111 01110010 01101100 01100100 00100001])

    describe '#bits' do
      it 'should calculate the correct result' do
        expect(string_instance.bits)
          .to eq('010010000110010101101100011011000110111100100000010101110110111101110010011011000110010000100001')
      end
    end
  end
end
