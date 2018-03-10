require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Google < Base
      URL_FORMATS = {
        full: /((https?)?:\/\/)?plus\.google\.com\/u\/\d{1,}\/(?<id>[\w\-\.\+]+)?/i,
        shorter: /((https?)?:\/\/)?plus.google.com\/(?<id>[\w\-\.\+]+)?/i
      }

      def provider
        :google
      end

      def url
        "https://plus.google.#{domain}/#{username}"
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          return m[:id] if m
        end
        nil
      end
    end
  end
end
