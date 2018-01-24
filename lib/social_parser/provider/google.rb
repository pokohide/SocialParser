require 'social_parser/provider/base'

module SocialParser
  module Provider
    class Google < Base
      URL_FORMATS = {
        full: /\A((http|https)?:\/\/)?(www\.)?google/
      }
    end
  end
end


# https://plus.google.com/u/0/+bakemonogatari777
# https://plus.google.com/u/0/+InaGat
# https://plus.google.com/u/0/+%E3%83%9F%E3%83%9F%E3%81%A1%E3%82%83%E3%82%93


# module SocialMediaParser
#   module Provider
#     class Google < Base
#       URL_REGEX = /(?:(?:http|https):\/\/)plus.google.com\/?(?:u\/\d{1,}\/|)(?:\+|)([\w\-\.\%]{1,})/i

#       def provider
#         'google'
#       end

#       def url
#         return url_from_attributes if url_from_attributes
#         if username
#           if Float(username)
#             "https://plus.google.com/#{username}"
#           end
#         end
#       rescue ArgumentError
#         "https://plus.google.com/+#{username}"
#       end

#       private

#       def parse_username_from_url
#         URL_REGEX.match(url_from_attributes).to_a[1]
#       end
#     end
#   end
# end
