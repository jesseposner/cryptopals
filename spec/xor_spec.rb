# frozen_string_literal: true

require 'xor'

RSpec.describe XOR do
  describe '::int' do
    it 'should calculate the correct result' do
      (0..10).each do |int1|
        (0..1000).to_a.reverse.lazy.each do |int2|
          expect(
            described_class.int(int1, int2)
          ).to eq(int1 ^ int2)
        end
      end
    end
  end

  describe '::bit' do
    it 'should calculate the correct result' do
      (0..1).each do |int1|
        (0..1).to_a.reverse.lazy.each do |int2|
          expect(
            described_class.bit(int1, int2)
          ).to eq(int1 ^ int2)
        end
      end
    end

    context "when the arguments aren't bits" do
      it 'should raise an error' do
        expect do
          described_class.bit(3, 0)
        end.to raise_error(
          StandardError, 'Arguments must be bits (i.e. 1 or 0)'
        )
      end
    end
  end
end
