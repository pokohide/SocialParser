require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Youtube < Base
      URL_FORMATS = {
        embed: /\A((https?)?:\/\/)?(www\.)?youtube\.com\/embed\/(?<id>[\w\-\.]+)\/?/i,
        video: /\A((https?)?:\/\/)?(www\.)?youtube\.com\/watch\?v=(?<id>[\w\-\.]+)\/?/i,
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
        if video?
          "https://www.youtube.#{domain}/watch?v=#{username}"
        else
          "https://www.youtube.#{domain}/#{type}/#{username}"
        end
      end

      def embed_url
        return super unless video?
        "https://www.youtube.#{domain}/embed/#{username}"
      end

      private

      def video?
        type == 'video'
      end

      def parse_from_url
        URL_FORMATS.each do |key, format|
          m = format.match(url_from_attributes)
          next unless m

          if key == :full
            @type = m[:type]
            return nil if @type != 'user'
          elsif key == :video || key == :embed
            @type = 'video'
          end
          return m[:id]
        end
        nil
      end
    end
  end
end
