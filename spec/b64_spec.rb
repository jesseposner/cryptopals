# frozen_string_literal: true

require 'b64'

RSpec.describe B64 do
  let(:ascii_str) { "I'm killing your brain like a poisonous mushroom" }

  describe '::encode_ascii' do
    it 'should encode correctly' do
      expect(described_class.encode_ascii(ascii_str))
        .to eq('SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t')
    end
  end
end
