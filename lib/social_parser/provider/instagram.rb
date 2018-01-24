require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Instagram < Base
      URL_FORMATS = {
        regular: /\A((https?)?:\/\/)?(www\.)?instagram\.com\/(stories\/)?(?<instagram>.+?)\/?\Z/
      }

      def provider
        :instagram
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          return m[:instagram] if m
        end
        nil
      end
    end
  end
end
