require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Twitter < Base
      URL_FORMATS = {
        full: /\A((https?):\/\/)?(www\.)?twitter\.com\/@?(?<id>[\w\-\.]+)/i
        # regular: /\Ahttps?:\/\/(www\.)?twitter\.com\/(?!share)(?!share\?)(?!intent\/)(?<id>.+?)\/?\Z/
      }

      def provider
        :twitter
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
