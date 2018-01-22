require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://qiita.com/pokohide' } }

    it 'returns a Qiita Object' do
      expect(parser).to be_a SocialParser::Provider::Qiita
    end
  end

  context 'with linkedin as provider and username as url_or_username' do
    let(:profile_attributes){ { url_or_username: 'pokohide', provider: :qiita } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://qiita.com/pokohide'
      expect(parser.provider).to eq :qiita
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'with linkedin as provider and username as url_or_username' do
    let(:profile_attributes){ { url_or_username: 'https://qiita.com/pokohide', provider: :qiita } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://qiita.com/pokohide'
      expect(parser.provider).to eq :qiita
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'with linkedin url and provider' do
    let(:profile_attributes){ { url: 'https://qiita.com/pokohide', provider: :qiita } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://qiita.com/pokohide'
      expect(parser.provider).to eq :qiita
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'url variations' do
    it 'parses username from url with trailing slash' do
      parser = described_class.parse 'https://qiita.com/pokohide/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url with www' do
      parser = described_class.parse 'https://www.qiita.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without https' do
      parser = described_class.parse 'www.qiita.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without http and www' do
      parser = described_class.parse 'qiita.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username with _ from url' do
      parser = described_class.parse 'https://qiita.com/poko_hide'
      expect(parser.username).to eq 'poko_hide'
    end

    it 'parses username from contributions url' do
      parser = described_class.parse 'https://qiita.com/pokohide/contributions'
      expect(parser.url).to eq 'https://qiita.com/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from article url' do
      parser = described_class.parse 'https://qiita.com/pokohide/items/43203f109fd95df9a7cc'
      expect(parser.username).to eq 'pokohide'
    end
  end
end
