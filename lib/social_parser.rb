require 'social_parser/version'

Dir[File.join(File.dirname(__FILE__), 'social_parser', 'provider', '*.rb')].each { |file| require file }

module SocialParser

  def self.parse(attrs)
    if attrs.is_a? String
      parse(url: attrs)
    else
      Provider::Base.parse(attrs)
    end
  end
end
