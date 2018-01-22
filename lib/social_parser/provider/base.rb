require 'social_parser/link'

module SocialParser
  module Provider
    class Base < ::SocialParser::Link

      def self.parse(attrs)
        if attrs[:provider]

          SocialParser::Provider.const_get(attrs[:provider].to_s.capitalize).new(attrs)
        else

          providers.map do |provider|
            SocialParser::Provider.const_get(provider.to_s.capitalize).new(attrs)
          end.find(&:valid?) or ::SocialParser::Link.new(attrs)
        end
      end

      def username
        return @username if @username
        if @url_or_username and invalid_url_format?(@url_or_username)
          @url_or_username
        elsif url_from_attributes
          parse_from_url
        end
      end

      def url
        return url_from_attributes if url_from_attributes
        "https://www.#{provider.to_s}.com/#{username}"
      end

      def valid?
        (@provider and @provider.downcase == provider) or
        (username and URI.parse(url_from_attributes).host.match("#{provider.to_s}.com"))
      rescue URI::BadURIError, URI::InvalidURIError
        false
      end

      private

      def parse_from_url
        URI.parse(url_from_attributes).path.split('/')[1]
      rescue URI::BadURIError, URI::InvalidURIError
        nil
      end

      def self.providers
        @providers ||= [:facebook, :github, :twitter, :youtube, :instagram, :linkedin, :medium, :qiita]
      end
    end
  end
end
