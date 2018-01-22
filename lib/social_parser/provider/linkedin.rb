require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Linkedin < Base
      URL_FORMATS = {
        full: /\A((http|https):\/\/)?(www\.)?linkedin\.com\/(?<type>(in|company|school))?\/(?<id>[\w\-\.]+)\/?/i,
        regular: /\Ahttps?:\/\/www\.linkedin\.com\/(?<id>.+?)\/?\Z/
      }

      def provider
        :linkedin
      end

      def url
        "https://www.linkedin.com/#{@type || 'in'}/#{username}"
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          if m
            @type = m[:type] || 'in'
            return m[:id].sub(/\?.*/m, '')
          end
        end
        nil
      end
    end
  end
end
