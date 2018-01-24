require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Pinterest < Base
      URL_FORMATS = {
        full: /\A((https?)?:\/\/)?(www\.)?pinterest\.(?<domain>(com|jp))\/(?<id>[\w\-\.]+)\/?/i
      }

      def provider
        :pinterest
      end

      def domain
        @domain || 'com'
      end

      def url
        @domain ||= 'com'
        "https://www.pinterest.#{domain}/#{username}"
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          if m
            @domain = m[:domain]
            return m[:id]
          end
        end
        nil
      end
    end
  end
end
