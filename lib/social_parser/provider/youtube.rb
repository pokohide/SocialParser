require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Youtube < Base
      URL_FORMATS = {
        regular: /(?:(?:http|https):\/\/)?(?:www.)?youtube\.com\/(?!channel|playlist)(?:user\/|)([\w\-\.]{1,})/i
      }

      def provider
        :youtube
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          return m.to_a[1] if m
        end
        nil
      end
    end
  end
end
