require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Github < Base
      URL_FORMATS = {
        full: /((https?)?:\/\/)?(www\.)?github\.com\/(?<id>[\w\-\.]+)?/i
        # regular: /\Ahttps?:\/\/github\.com\/(?<id>.+?)\/?\Z/
      }

      def provider
        :github
      end

      def url
        "https://github.#{domain}/#{username}"
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
