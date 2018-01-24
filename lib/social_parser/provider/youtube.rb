require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Youtube < Base
      URL_FORMATS = {
        full: /\A((https?)?:\/\/)?(www\.)?youtube\.com\/(?<type>(user|channel|playlist))\/(?<id>[\w\-\.]+)\/?/i,
        shortend: /\A((https?)?:\/\/)?(www\.)?youtube\.com\/(?<id>[\w\-\.]+)\/?/i,
      }

      def provider
        :youtube
      end

      def type
        @type || 'user'
      end

      def url
        "https://www.youtube.#{domain}/#{type}/#{username}"
      end

      private

      def parse_from_url
        URL_FORMATS.each do |key, format|
          m = format.match(url_from_attributes)
          next unless m

          if key == :full
            @type = m[:type]
            return nil if @type != 'user'
          end
          return m[:id]
        end
        nil
      end
    end
  end
end
