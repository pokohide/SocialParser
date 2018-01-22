require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://www.instagram.com/poko_hide'} }

    it 'returns a Instagram Object' do
      expect(parser).to be_a SocialParser::Provider::Instagram
    end
  end

  context 'with instagram url and provider' do
    let(:profile_attributes) { { url: 'https://www.instagram.com/poko_hide', provider: :instagram } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.instagram.com/poko_hide'
      expect(parser.provider).to eq :instagram
      expect(parser.username).to eq 'poko_hide'
    end
  end

  context 'with instagram as provider and username as url_or_username' do
    let(:profile_attributes) { { url_or_username: 'poko_hide', provider: :instagram } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.instagram.com/poko_hide'
      expect(parser.provider).to eq :instagram
      expect(parser.username).to eq 'poko_hide'
    end
  end

  context 'with instagram as provider and username as url_or_username' do
    let(:profile_attributes) { { url: 'https://www.instagram.com/poko_hide', provider: :instagram } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.instagram.com/poko_hide'
      expect(parser.provider).to eq :instagram
      expect(parser.username).to eq 'poko_hide'
    end
  end

  context 'url variations' do
    it 'parses username from url with trailing slash' do
      parser = described_class.parse 'https://www.instagram.com/poko_hide/'
      expect(parser.username).to eq 'poko_hide'
    end

    it 'parses username from url with www' do
      parser = described_class.parse 'https://www.instagram.com/poko_hide'
      expect(parser.username).to eq 'poko_hide'
    end

    it 'parses username from url without http and www' do
      parser = described_class.parse 'instagram.com/poko_hide'
      expect(parser.username).to eq 'poko_hide'
    end

    it 'parses username from story url' do
      parser = described_class.parse 'https://www.instagram.com/stories/otomore01/'
      expect(parser.username).to eq 'otomore01'
    end
  end
end
