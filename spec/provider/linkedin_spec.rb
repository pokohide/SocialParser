require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://www.linkedin.com/in/pokohide' } }

    it 'returns a Linkedin Object' do
      expect(parser).to be_a SocialParser::Provider::Linkedin
    end
  end

  context 'with linkedin as provider and username as url_or_username' do
    let(:profile_attributes){ { url_or_username: 'pokohide', provider: :linkedin } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.linkedin.com/in/pokohide'
      expect(parser.provider).to eq :linkedin
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'with linkedin as provider and username as url_or_username' do
    let(:profile_attributes){ { url_or_username: 'www.linkedin.com/in/pokohide', provider: :linkedin } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.linkedin.com/in/pokohide'
      expect(parser.provider).to eq :linkedin
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'with linkedin url and provider' do
    let(:profile_attributes){ { url: 'http://linkedin.com/in/pokohide', provider: :linkedin } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.linkedin.com/in/pokohide'
      expect(parser.provider).to eq :linkedin
      expect(parser.username).to eq 'pokohide'
    end
  end

  context 'url variations' do
    it 'parses username from url with trailing slash' do
      parser = described_class.parse 'https://linkedin.com/in/pokohide/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without www' do
      parser = described_class.parse 'https://linkedin.com/in/pokohide/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url with http' do
      parser = described_class.parse 'http://linkedin.com/in/pokohide/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without https' do
      parser = described_class.parse 'www.linkedin.com/in/pokohide/'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from url without http and www' do
      parser = described_class.parse 'linkedin.com/in/pokohide'
      expect(parser.username).to eq 'pokohide'
    end

    it 'parses username from company url' do
      parser = described_class.parse 'https://www.linkedin.com/company/linkedin/'
      expect(parser.username).to eq 'linkedin'
    end

    it 'parses username from company jobs url' do
      parser = described_class.parse 'https://www.linkedin.com/company/linkedin/jobs/'
      expect(parser.url).to eq 'https://www.linkedin.com/company/linkedin'
      expect(parser.username).to eq 'linkedin'
    end

    it 'parses username from school url' do
      parser = described_class.parse 'https://www.linkedin.com/school/11361/'
      expect(parser.url).to eq 'https://www.linkedin.com/school/11361'
      expect(parser.username).to eq '11361'
    end

    it 'parser username from school alumni url' do
      parser = described_class.parse 'https://www.linkedin.com/school/11361/alumni/'
      expect(parser.url).to eq 'https://www.linkedin.com/school/11361'
      expect(parser.username).to eq '11361'
    end

    it 'parser username from school url with parameters' do
      parser = described_class.parse 'https://www.linkedin.com/school/11361/alumni/?facetCurrentCompany=1252'
      expect(parser.url).to eq 'https://www.linkedin.com/school/11361'
      expect(parser.username).to eq '11361'
    end

    it 'parser username from url with kanji' do
      parser = described_class.parse 'https://www.linkedin.com/in/大輝-山本-2581b589/'
      expect(parser.username).to eq '大輝-山本-2581b589'
    end

    it 'parses username from url with some parameters' do
      parser = described_class.parse 'https://www.linkedin.com/company/linkedin?hoge=www&fugaa=yyy'
      expect(parser.url).to eq 'https://www.linkedin.com/company/linkedin'
      expect(parser.username).to eq 'linkedin'
    end
  end
end
