require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Linkedin < Base
      URL_FORMATS = {
        regular: /\Ahttps?:\/\/www\.linkedin\.com\/(?<linkedin>.+?)\/?\Z/
      }
      # /(?:(?:http|https):\/\/)?(?:www.|[a-z]{2}.)?linkedin.com\/in\/([\w]*)/i

      def provider
        :linkedin
      end

      def url
        "https://www.linkedin.com/in/#{username}"
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          return m[:linkedin].sub(/\?.*/m, '') if m
        end
        nil
      end
    end
  end
end
