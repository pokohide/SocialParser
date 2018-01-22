require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse profile_attributes }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://www.twitter.com/hyde141421356' } }

    it 'returns a Twitter Object' do
      expect(parser).to be_a SocialParser::Provider::Twitter
    end
  end

  context 'with twitter as provider and username as url_or_username' do
    let(:profile_attributes) { { url_or_username: 'hyde141421356', provider: :twitter } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.twitter.com/hyde141421356'
      expect(parser.provider).to eq :twitter
      expect(parser.username).to eq 'hyde141421356'
    end
  end

  context 'with twitter as provider and username url_or_username' do
    let(:profile_attributes) { { url_or_username: 'https://www.twitter.com/hyde141421356', provider: :twitter } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.twitter.com/hyde141421356'
      expect(parser.provider).to eq :twitter
      expect(parser.username).to eq 'hyde141421356'
    end
  end

  context 'with twitter url and username' do
    let(:profile_attributes) { { url: 'https://www.twitter.com/hyde141421356', provider: :twitter } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.twitter.com/hyde141421356'
      expect(parser.provider).to eq :twitter
      expect(parser.username).to eq 'hyde141421356'
    end
  end

  context 'url variations' do
    it 'parses username from url without trailing slash' do
      parser = described_class.parse 'https://twitter.com/hyde141421356'
      expect(parser.username).to eq 'hyde141421356'
    end

    it 'parses username from url with www' do
      parser = described_class.parse 'https://www.twitter.com/hyde141421356/'
      expect(parser.username).to eq 'hyde141421356'
    end

    it 'parses username from url without http' do
      parser = described_class.parse 'twitter.com/hyde141421356/'
      expect(parser.username).to eq 'hyde141421356'
    end

    it 'parses username from tweet url' do
      parser = described_class.parse 'https://twitter.com/appp_la/status/955419877719887872'
      expect(parser.username).to eq 'appp_la'
    end

    it 'parses username from twitter media url' do
      parser = described_class.parse 'https://twitter.com/appp_la/media'
      expect(parser.username).to eq 'appp_la'
    end
  end
end
