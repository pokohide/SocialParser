require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Facebook < Base
      URL_FORMATS = {
        full: /(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/[\w\-]*)?(?:[?\d\-]*\/)?(?:profile.php\?id=(?=\d.*))?(?<id>[\w\-\.]*)?/i,
        regular: /\Ahttps?:\/\/www\.facebook\.com\/(?!sharer\/)(?!share\.php\?)(?!sharer\.php\?)(?<id>.+?)\/?\Z/,
        shorter: /\Ahttps?:\/\/facebook\.com\/(?!sharer\/)(?!share\.php\?)(?!sharer\.php\?)(?<id>.+?)\/?\Z/
      }

      def provider
        :facebook
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
