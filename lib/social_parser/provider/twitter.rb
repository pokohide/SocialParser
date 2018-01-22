require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Twitter < Base
      URL_FORMATS = {
        regular: /\Ahttps?:\/\/twitter\.com\/(?!share)(?!share\?)(?!intent\/)(?<twitter>.+?)\/?\Z/
      }
      # /(?:(?:http|https):\/\/)?(?:www.)?twitter.com\/(?:(?:\w)*#!\/)?(\w*)/i

      def provider
        :twitter
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          return m[:twitter].sub(/\?.*/m, '') if m
        end
        nil
      end
    end
  end
end
