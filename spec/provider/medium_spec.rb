require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://medium.com/@pokohide' } }

    it 'returns a Medium Object' do
      expect(parser).to be_a SocialParser::Provider::Medium
    end
  end

  context 'with linkedin as provider and username as url_or_username' do
    let(:profile_attributes){ { url_or_username: '@pokohide', provider: :medium } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://medium.com/@pokohide'
      expect(parser.provider).to eq :medium
      expect(parser.username).to eq '@pokohide'
    end
  end

  context 'with linkedin as provider and username as url_or_username' do
    let(:profile_attributes){ { url_or_username: 'https://medium.com/@pokohide', provider: :medium } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://medium.com/@pokohide'
      expect(parser.provider).to eq :medium
      expect(parser.username).to eq '@pokohide'
    end
  end

  context 'with linkedin url and provider' do
    let(:profile_attributes){ { url: 'https://medium.com/@pokohide', provider: :medium } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://medium.com/@pokohide'
      expect(parser.provider).to eq :medium
      expect(parser.username).to eq '@pokohide'
    end
  end

  context 'url variations' do
    it 'parses username from url with trailing slash' do
      parser = described_class.parse 'https://medium.com/@pokohide/'
      expect(parser.username).to eq '@pokohide'
    end

    it 'parses username from url with @' do
      parser = described_class.parse 'https://medium.com/@pokohide'
      expect(parser.username).to eq '@pokohide'
    end

    it 'parses username from url without www' do
      parser = described_class.parse 'https://medium.com/@pokohide'
      expect(parser.username).to eq '@pokohide'
    end

    it 'parses username from url with http' do
      parser = described_class.parse 'medium.com/@pokohide/'
      expect(parser.username).to eq '@pokohide'
    end

    it 'parses username from url without https' do
      parser = described_class.parse 'http://www.medium.com/@pokohide'
      expect(parser.username).to eq '@pokohide'
    end

    it 'parses username from url without http and www' do
      parser = described_class.parse 'medium.com/@pokohide'
      expect(parser.username).to eq '@pokohide'
    end

    it 'parses username from url with highlights' do
      parser = described_class.parse 'https://medium.com/@pokohide/highlights'
      expect(parser.url).to eq 'https://medium.com/@pokohide'
      expect(parser.username).to eq '@pokohide'
    end

    it 'parses username with . from url' do
      parser = described_class.parse 'https://medium.com/@muehler.v/'
      expect(parser.username).to eq '@muehler.v'
    end

    it 'parses username from article url' do
      parser = described_class.parse 'https://medium.com/@borisohayon/ios-opencv-and-swift-1ee3e3a5735b'
      expect(parser.username).to eq '@borisohayon'
    end
  end
end
