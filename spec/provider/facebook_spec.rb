require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://www.facebook.com/hidenobu.sakai.119' } }

    it 'returns a Facebook Object' do
      expect(parser).to be_a SocialParser::Provider::Facebook
    end
  end

  context 'with facebook url and provider' do
    let(:profile_attributes) { { url: 'https://www.facebook.com/someone', provider: :facebook } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.facebook.com/someone'
      expect(parser.provider).to eq :facebook
      expect(parser.username).to eq 'someone'
    end
  end

  context 'with facebook profile_id url and provider' do
    let(:profile_attributes) { { url: 'https://www.facebook.com/profile.php?id=644727125&fref=nf', provider: :facebook } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.facebook.com/profile.php?id=644727125&fref=nf'
      expect(parser.provider).to eq :facebook
      expect(parser.username).to eq '644727125'
    end
  end

  context 'with facebook username as url_or_username and provider' do
    let(:profile_attributes) { { url_or_username: 'pokohide', provider: :facebook } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.facebook.com/pokohide'
      expect(parser.provider).to eq :facebook
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'with facebook http url as url_or_username and case insensitive provider' do
    let(:profile_attributes) { { url_or_username: 'https://www.facebook.com/pokohide' , provider: :facebook } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.facebook.com/pokohide'
      expect(parser.provider).to eq :facebook
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'url variations' do

    it 'parses username from url with trailing slash' do
      parser = described_class.parse 'https://www.facebook.com/pokohide/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without www' do
      parser = described_class.parse 'https://facebook.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without http' do
      parser = described_class.parse 'www.facebook.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without http and www' do
      parser = described_class.parse 'facebook.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from photo stream page url' do
      parser = described_class.parse 'https://www.facebook.com/pokohide/photos_stream'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url with some parameters' do
      parser = described_class.parse 'https://www.facebook.com/pokohide/videos?lst=xxxx&ref=yyy'
      expect(parser.username).to eq 'pokohide'
    end
  end
end
