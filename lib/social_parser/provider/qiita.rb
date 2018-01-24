require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Qiita < Base
      URL_FORMATS = {
        regular: /\A((https?)?:\/\/)?(www\.)?qiita\.com\/(?<id>[\w\-\.]+)/i
      }

      def provider
        :qiita
      end

      def url
        "https://qiita.#{domain}/#{username}"
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          return m[:id].sub(/\?.*/m, '') if m
        end
        nil
      end
    end
  end
end
