require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://github.com/hyde2able' } }

    it 'returns a Github Object' do
      expect(parser).to be_a SocialParser::Provider::Github
    end
  end

  context 'with github url and provider' do
    let(:profile_attributes) { { url: 'https://github.com/hyde2able', provider: :github } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://github.com/hyde2able'
      expect(parser.provider).to eq :github
      expect(parser.username).to eq 'hyde2able'
    end
  end

  context 'with github as provider and username as url_or_username' do
    let(:profile_attributes) { { url_or_username: 'hyde2able', provider: :github } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://github.com/hyde2able'
      expect(parser.provider).to eq :github
      expect(parser.username).to eq 'hyde2able'
    end
  end

  context 'with github as provider and url as url_or_username' do
    let(:profile_attributes) { { url_or_username: 'https://github.com/hyde2able', provider: :github } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://github.com/hyde2able'
      expect(parser.provider).to eq :github
      expect(parser.username).to eq 'hyde2able'
    end
  end

  context 'url variations' do

    it 'parses username from url with trailing slash' do
      parser = described_class.parse 'https://github.com/hyde2able/'
      expect(parser.username).to eq 'hyde2able'
    end

    it 'parses username from url without www' do
      parser = described_class.parse 'https://github.com/hyde2able'
      expect(parser.username).to eq 'hyde2able'
    end

    it 'parses username from url without http' do
      parser = described_class.parse 'www.github.com/hyde2able'
      expect(parser.username).to eq 'hyde2able'
    end

    it 'parses username from url without http and www' do
      parser = described_class.parse 'github.com/hyde2able'
      expect(parser.username).to eq 'hyde2able'
    end

    it 'parses username from repo url' do
      parser = described_class.parse 'https://github.com/hyde2able/SocialParser'
      expect(parser.username).to eq 'hyde2able'
    end

    it 'parses username from url with tab parameters' do
      parser = described_class.parse 'https://github.com/hyde2able?tab=repositories'
      expect(parser.username).to eq 'hyde2able'
    end

    it 'parses username from repo open issues url' do
      parser = described_class.parse 'https://github.com/hyde2able/SocialParser/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+test'
      expect(parser.username).to eq 'hyde2able'
    end
  end
end
