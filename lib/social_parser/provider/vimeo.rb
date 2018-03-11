require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Vimeo < Base
      URL_FORMATS = {
        embed: /\A((https?)?:\/\/)?player\.vimeo\.com\/video\/(?<id>\d+)\/?/i,
        video: /\A((https?)?:\/\/)?(www\.)?vimeo\.com\/(?<id>\d+)\/?/i,
        channels: /\A((https?)?:\/\/)?(www\.)?vimeo\.com\/channels\/(?<id>[\w\-\.]+)\/?/i,
        user: /\A((https?)?:\/\/)?(www\.)?vimeo\.com\/(?<id>[\w\-\.]+)\/?/i
      }

      def provider
        :vimeo
      end

      def type
        @type || 'user'
      end

      def url
        if video?
          "https://vimeo.#{domain}/#{id}"
        elsif channels?
          "https://vimeo.#{domain}/channels/#{username}"
        else
          "https://vimeo.#{domain}/#{username}"
        end
      end

      def embed_url
        return super unless video?
        "https://player.vimeo.#{domain}/video/#{id}"
      end

      private

      def video?; (type == 'video' || type == 'embed') end
      def channels?; type =='channels' end

      def parse_from_url
        URL_FORMATS.each do |key, format|
          m = format.match(url_from_attributes)
          next unless m
          @type = key.to_s
          return m[:id]
        end
        nil
      end
    end
  end
end
