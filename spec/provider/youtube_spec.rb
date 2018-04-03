require 'spec_helper'

RSpec.describe SocialParser do
  let(:parser) { described_class.parse(profile_attributes) }

  context 'correct class' do
    let(:profile_attributes) { { url: 'https://www.youtube.com/user/norunine' } }

    it 'returns a Youtube object' do
      expect(parser).to be_a SocialParser::Provider::Youtube
    end
  end

  context 'with url and provider' do
    let(:profile_attributes){ { url: 'https://www.youtube.com/user/norunine', provider: :youtube } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.youtube.com/user/norunine'
      expect(parser.provider).to eq :youtube
      expect(parser.username).to eq 'norunine'
    end
  end

  context 'with username and provider' do
    let(:profile_attributes){ { username: 'norunine', provider: :youtube } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.youtube.com/user/norunine'
      expect(parser.provider).to eq :youtube
      expect(parser.username).to eq 'norunine'
    end
  end

  context 'with username as url_or_username and provider' do
    let(:profile_attributes){ { url_or_username: 'norunine', provider: :youtube } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.youtube.com/user/norunine'
      expect(parser.provider).to eq :youtube
      expect(parser.username).to eq 'norunine'
    end
  end

  context 'youtube video url' do
    let(:profile_attributes) { { url: 'https://www.youtube.com/watch?v=WOvdMz4yM9U' } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.youtube.com/watch?v=WOvdMz4yM9U'
      expect(parser.provider).to eq :youtube
      expect(parser.id).to eq 'WOvdMz4yM9U'
      expect(parser.type).to eq 'video'
    end
  end

  context 'embed video url' do
    let(:profile_attributes) { { url: 'https://www.youtube.com/embed/CJAQrNtVMLM' } }

    it 'returns the parsed attributes' do
      expect(parser.url).to eq 'https://www.youtube.com/watch?v=CJAQrNtVMLM'
      expect(parser.provider).to eq :youtube
      expect(parser.id).to eq 'CJAQrNtVMLM'
      expect(parser.embed_url).to eq 'https://www.youtube.com/embed/CJAQrNtVMLM'
    end
  end

  context 'convert video url into embed url' do
    let(:profile_attributes) { { url: 'https://www.youtube.com/watch?v=WOvdMz4yM9U' } }

    it 'returns the embed url' do
      expect(parser.id).to eq 'WOvdMz4yM9U'
      expect(parser.embed_url).to eq 'https://www.youtube.com/embed/WOvdMz4yM9U'
    end
  end

  context 'convert user url into embed url return nil' do
    let(:profile_attributes) { { url: 'https://www.youtube.com/user/norunine' } }

    it 'cause an errors' do
      expect(parser.embed_url).to eq nil
    end
  end

  context 'url variations' do
    it 'parses username from url with trailing slash' do
      parser = described_class.parse 'https://www.youtube.com/user/norunine/'
      expect(parser.username).to eq 'norunine'
    end

    it 'parses username from shortcut url' do
      parser = described_class.parse 'https://www.youtube.com/norunine'
      expect(parser.username).to eq 'norunine'
    end

    it 'parses username from a user videos url' do
      parser = described_class.parse 'https://www.youtube.com/user/norunine/videos'
      expect(parser.username).to eq 'norunine'
    end

    it 'parses username from url with parameter' do
      parser = described_class.parse 'https://www.youtube.com/user/norunine/videos?disable_polymer=1'
      expect(parser.username).to eq 'norunine'
    end

    it 'parses username from a users channels url' do
      parser = described_class.parse "https://www.youtube.com/user/collegehumor/channels"
      expect(parser.username).to eq "collegehumor"
    end

    it "doesn't parse username from channel urls" do
      parser = described_class.parse 'https://www.youtube.com/channel/UC2GuoutVyegg6PUK88lLpjw'
      expect(parser.username).to eq nil
      expect(parser.url).to eq 'https://www.youtube.com/channel/UC2GuoutVyegg6PUK88lLpjw'
    end
  end
end
