require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://www.pinterest.jp/pokohide/' } }

    it 'returns a Pinterest Object' do
      expect(parser).to be_a SocialParser::Provider::Pinterest
    end
  end

  context 'with pinterest url and provider' do
    let(:profile_attributes){ { url: 'https://www.pinterest.jp/pokohide/', provider: :pinterest } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.pinterest.com/pokohide'
      expect(parser.provider).to eq :pinterest
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'with pinterest as provider and username as url_or_username' do
    let(:profile_attributes){ { url_or_username: 'pokohide', provider: :pinterest } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.pinterest.com/pokohide'
      expect(parser.provider).to eq :pinterest
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'with pinterest as provider and username as url_or_username' do
    let(:profile_attributes){ { url_or_username: 'https://www.pinterest.com/pokohide', provider: :pinterest } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.pinterest.com/pokohide'
      expect(parser.provider).to eq :pinterest
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'url variations' do
    it 'parses username from url without trailing slash' do
      parser = described_class.parse 'https://www.pinterest.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without www' do
      parser = described_class.parse 'http://pinterest.jp/pokohide/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from pinterest pins url' do
      parser = described_class.parse 'https://www.pinterest.jp/pokohide/pins/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from jp url' do
      parser = described_class.parse 'https://www.pinterest.jp/pokohide/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from pinterest followers url' do
      parser = described_class.parse 'https://www.pinterest.jp/pokohide/followers/'
      expect(parser.username).to eq 'pokohide'
    end
  end
end
