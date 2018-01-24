require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Linkedin < Base
      URL_FORMATS = {
        full: /\A((https?):\/\/)?(www\.)?linkedin\.com\/(?<type>(in|company|school))?\/(?<id>[\w\-\.]+)\/?/i
      }

      def provider
        :linkedin
      end

      def type
        @type || 'in'
      end

      def url
        "https://www.linkedin.#{domain}/#{type}/#{username}"
      end

      private

      def parse_from_url
        URL_FORMATS.values.each do |format|
          m = format.match(url_from_attributes)
          if m
            @type = m.names.include?('type') ? m[:type] : nil
            return m[:id]
          end
        end
        nil
      end
    end
  end
end
