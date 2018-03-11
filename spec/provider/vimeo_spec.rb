require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://vimeo.com/alextiernan' } }

    it 'returns a Vimeo object' do
      expect(parser).to be_a SocialParser::Provider::Vimeo
    end
  end

  context 'with url and provider' do
    let(:profile_attributes){ { url: 'https://vimeo.com/alextiernan', provider: :vimeo } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://vimeo.com/alextiernan'
      expect(parser.provider).to eq :vimeo
      expect(parser.username).to eq 'alextiernan'
    end
  end

  context 'with username and provider' do
    let(:profile_attributes){ { username: 'alextiernan', provider: :vimeo } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://vimeo.com/alextiernan'
      expect(parser.provider).to eq :vimeo
      expect(parser.username).to eq 'alextiernan'
    end
  end

  context 'with username as url_or_username and provider' do
    let(:profile_attributes){ { url_or_username: 'alextiernan', provider: :vimeo } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://vimeo.com/alextiernan'
      expect(parser.provider).to eq :vimeo
      expect(parser.username).to eq 'alextiernan'
    end
  end

  context 'channel url' do
    let(:profile_attributes) { { url: 'https://vimeo.com/channels/shortoftheweek/videos' } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://vimeo.com/channels/shortoftheweek'
      expect(parser.provider).to eq :vimeo
      expect(parser.id).to eq 'shortoftheweek'
      expect(parser.type).to eq 'channels'
    end
  end

  context 'vimeo video url' do
    let(:profile_attributes) { { url: 'https://vimeo.com/155855866' } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://vimeo.com/155855866'
      expect(parser.provider).to eq :vimeo
      expect(parser.id).to eq '155855866'
      expect(parser.type).to eq 'video'
    end
  end

  context 'vimeo video url' do
    let(:profile_attributes) { { url: 'https://vimeo.com/252718756/likes' } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://vimeo.com/252718756'
      expect(parser.provider).to eq :vimeo
      expect(parser.id).to eq '252718756'
      expect(parser.type).to eq 'video'
    end
  end

  context 'vimeo embed video url' do
    let(:profile_attributes) { { url: 'https://player.vimeo.com/video/257871741?title=0&byline=0&portrait=0' } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://vimeo.com/257871741'
      expect(parser.provider).to eq :vimeo
      expect(parser.id).to eq '257871741'
      expect(parser.embed_url).to eq 'https://player.vimeo.com/video/257871741'
    end
  end

  context 'convert video url into embed url' do
    let(:profile_attributes) { { url: 'https://vimeo.com/155855866' } }

    it 'returns the embed url' do
      expect(parser.embed_url).to eq 'https://player.vimeo.com/video/155855866'
    end
  end

  context 'convert user url into embed url cause an error' do
    let(:profile_attributes) { { url: 'https://vimeo.com/alextiernan' } }

    it 'cause an errors' do
      expect { parser.embed_url }.to raise_error(SocialParser::InvalidURIError)
    end
  end

  context 'url variations' do
    it 'parses username from url with trailing slash' do
      parser = described_class.parse 'https://vimeo.com/alextiernan/'
      expect(parser.username).to eq 'alextiernan'
    end

    it 'parses username from url with www' do
      parser = described_class.parse 'https://www.vimeo.com/alextiernan'
      expect(parser.username).to eq 'alextiernan'
    end

    it 'parses username from a user videos url' do
      parser = described_class.parse 'https://www.youtube.com/user/norunine/videos'
      expect(parser.username).to eq 'norunine'
    end

    it 'parses username from url without http' do
      parser = described_class.parse 'www.vimeo.com/alextiernan'
      expect(parser.username).to eq 'alextiernan'
    end

    it 'parses username from url without http and www' do
      parser = described_class.parse 'vimeo.com/alextiernan'
      expect(parser.username).to eq 'alextiernan'
    end

    it 'parses username from url with parameter' do
      parser = described_class.parse 'https://www.vimeo.com/alextiernan?disable_polymer=1'
      expect(parser.username).to eq 'alextiernan'
    end
  end
end
