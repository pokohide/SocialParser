require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Github < Base
      URL_FORMATS = {
        regular: /\Ahttps?:\/\/github\.com\/(?<github>.+?)\/?\Z/
      }

      def provider
        :twitter
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          return m[:github].sub(/\?.*/m, '') if m
        end
        nil
      end
    end
  end
end
