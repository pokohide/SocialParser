require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://plus.google.com/115767119826630448735' } }

    it 'returns a Google Object' do
      expect(parser).to be_a SocialParser::Provider::Google
    end
  end

  context 'with google shorter url and provider' do
    let(:profile_attributes) { { url: 'https://plus.google.com/someone', provider: :google } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://plus.google.com/someone'
      expect(parser.provider).to eq :google
      expect(parser.username).to eq 'someone'
    end
  end

  context 'with google full url and provider' do
    let(:profile_attributes) { { url: 'https://plus.google.com/u/0/someone', provider: :google } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://plus.google.com/someone'
      expect(parser.provider).to eq :google
      expect(parser.username).to eq 'someone'
    end
  end

  context 'with google username as url_or_username and provider' do
    let(:profile_attributes) { { url_or_username: 'pokohide', provider: :google } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://plus.google.com/pokohide'
      expect(parser.provider).to eq :google
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'with google https url as url_or_username and case insensitive provider' do
    let(:profile_attributes) { { url_or_username: 'https://plus.google.com/pokohide' , provider: :google } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://plus.google.com/pokohide'
      expect(parser.provider).to eq :google
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'url variations' do

    it 'parses username from url with trailing slash' do
      parser = described_class.parse 'https://plus.google.com/pokohide/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without http' do
      parser = described_class.parse 'plus.google.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without http and www' do
      parser = described_class.parse 'facebook.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url with some parameters' do
      parser = described_class.parse 'https://plus.google.com/pokohide/videos?lst=xxxx&ref=yyy'
      expect(parser.username).to eq 'pokohide'
    end
  end
end
